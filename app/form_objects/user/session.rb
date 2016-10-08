require "bcrypt"

class Session
  include ActiveModel::Model

  attr_reader :resource
  attr_accessor :model
  attr_accessor :email
  attr_accessor :password
  attr_accessor :remember_me
  attr_reader :remember_me_token
  attr_reader :remember_me_token_expires_at

  validate :authenticate

  def initialize model=User, attrs={}
    @model = model
    super(attrs)
  end

  def authenticate
    @resource = model.where(:email => /^#{Regexp.quote(email.try(:strip))}$/i).first
    return errors.add(:email, "Email address not found") unless resource
    return errors.add(:password, "Password is not valid") unless BCrypt::Password.new(@resource.encrypted_password) == password
  end

  def remember_me_token
    @remember_me_token ||= SecureRandom.hex(64)
  end

  def remember_me_token_expires_at
    @remember_me_token_expires_at ||= 5.days.from_now
  end

  def save
    if valid?
      if model == User and remember_me == "1"
        @resource.remember_me_token = remember_me_token
        @resource.remember_me_token_expires_at = remember_me_token_expires_at
        @resource.save!
      end
    end
  end
end
