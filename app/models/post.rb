class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String  

  validates :title, uniqueness: true
  validates :content, uniqueness: true
end