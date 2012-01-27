class Reject < ActiveRecord::Base
  include Control::State

  belongs_to :product
  next_states :none
end
