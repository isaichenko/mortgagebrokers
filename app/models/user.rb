class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  #user model server validations
  validates_presence_of :first_name , :last_name

  #associated model relations
  has_one :profile 
  belongs_to :role , optional: true
  has_many :borrower_requests
  has_many :broker_invitations
  has_many :bids
  has_many :transactions 

  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def self.borrower_request_brokers borrower_request 
    users  = User.joins(:profile).where(role_id: get_role(BROKER),verification_status: BROKER_VERIFIED)
    # users  = User.joins(:profile).where(role_id: get_role(BROKER),verification_status: BROKER_VERIFIED)
    # .where('profiles.mortgage_types LIKE ?', "%#{borrower_request.mortgage_type}%")
    # .select{ |user|  (user.profile.areas.any? {|h| (h[:city] == borrower_request.place[0][:city] or h[:state] == borrower_request.place[0][:state])}) }
    return users
  end 
  def self.get_role role
    return Role.where(name: role).first.id 
  end      
end
