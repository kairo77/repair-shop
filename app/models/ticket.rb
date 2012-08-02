class Ticket < ActiveRecord::Base
  attr_accessible :closed, :customer_id, :manufacturer, :model, :notes, :problem, :serial_number, :solution
  belongs_to :customer
end
