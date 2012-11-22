require 'securerandom'
class User < ActiveRecord::Base
  attr_accessible :city, :email, :first_name, :foto, :last_name, :location_code, :street, :token
  has_many :applications
  validates :email, :uniqueness => { :case_sensitive => false}, :allow_blank => false, :on => :create
  validates :city, :presence => true, :allow_blank => false, :on => :update
  validates :first_name, :presence => true,  :allow_blank => false, :on => :update
  validates :last_name, :presence => true,  :allow_blank => false, :on => :update
  validates :street, :presence => true,  :allow_blank => false, :on => :update
  validates :foto, :presence => true,  :allow_blank => false, :on => :update
  validates :location_code, :presence => true,  :allow_blank => false,  :on => :update
  validates :phone, presence: true, allow_blank: false, on: :update

  before_validation(:on => :create) do
    
    token = SecureRandom.hex(64) # Annahme: Ausreichend Zufall damit die Random Strings nicht crashen, TODO: sicherstellen
    self.token = token	
  end
end
