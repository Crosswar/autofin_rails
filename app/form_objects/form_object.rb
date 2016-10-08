module FormObject
  extend ActiveSupport::Concern
  extend ActiveModel::Callbacks

  include ActiveModel::Serialization
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  included do
    attr_reader :resource
    class_attribute :resource_name
    define_model_callbacks :save
    define_model_callbacks :create

    delegate :persisted?, to: :resource

    def initialize resource, attributes={}
      @resource = resource
      self.attributes= attributes
    end
  end

  def resource= resource
    @resource = resource
  end

  def attributes= attributes
    for key, value in attributes
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end

  def save
    if valid?
      run_callbacks :save do
        unless persisted?
          run_callbacks :create do
            resource.save
          end
        else
          resource.save
        end
      end
    end
  end

  module ClassMethods
    def property name, options={}
      if options.has_key? :through
        delegate name, to: options[:through]
        delegate "#{name}_was", to: options[:through]
        delegate "#{name}=", to: options[:through]
      else
        delegate name, to: :resource
        delegate "#{name}_was", to: :resource
        delegate "#{name}=", to: :resource
      end
    end

    def readonly_property name, options={}
      if options.has_key? :through
        delegate name, to: options[:through]
      else
        delegate name, to: :resource
      end
    end

    def resource name
      self.resource_name = name ? name.to_s : nil
      delegate :id, to: :resource
      delegate :persisted?, to: :resource
    end

    def model_name
      if self.resource_name
        ActiveModel::Name.new(self, nil, self.resource_name)
      else
        ActiveModel::Name.new(self)
      end
    end

    def save resource, attributes={}
      form_object = new(resource)
      form_object.attributes=(attributes)
      form_object.save
      form_object
    end
  end
end
