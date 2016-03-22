class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user

  validates :title, :presence => true
  validates :body, :presence => true
end
