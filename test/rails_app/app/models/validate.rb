class Validate < ActiveRecord::Base
  include Control::State

  belongs_to :product
  
  next_states :box, :reject
end
