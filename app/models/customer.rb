class Customer < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :company_name, :contact_preference, :email, :fax, :first_name, :home, :last_name, :middle_name, :mobile, :state, :suffix, :work, :zip
  has_many :tickets
  
  def name
    name = ""
    name << first_name unless first_name.blank?
    name << " " + middle_name unless middle_name.blank?
    name << " " + last_name unless last_name.blank?
    name << " @" unless last_name.blank? || company_name.blank?
    name << " #{company_name}" unless company_name.blank?
    name
  end
  
  def address
    address = ""
    address << "#{address1}<br/>" unless address1.blank?
    address << "#{address2}<br/>" unless address2.blank?
    address << "#{city}, " unless city.blank?
    address << "#{state} " unless state.blank?
    address << zip unless zip.blank?
    address.html_safe
  end
  
end
