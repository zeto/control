class Product < ActiveRecord::Base
  include Control::Workflow

  has_many :assemblies
  has_many :validates
  has_many :boxes
  has_many :rejects
end
