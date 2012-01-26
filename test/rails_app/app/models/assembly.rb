class Assembly < ActiveRecord::Base
  include Control::State

  belongs_to :product
end
