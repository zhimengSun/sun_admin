class Resource < ActiveRecord::Base
  has_and_belongs_to_many :roles
  validates :name, :url, presence: true
end
