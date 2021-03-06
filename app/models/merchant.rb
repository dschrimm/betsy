class Merchant < ActiveRecord::Base
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # make email have format requirements

  def self.build_from_github(auth_hash) # factoring method - creates a new User and populates it with data from the auth_hash
    merchant       = Merchant.new
    merchant.uid   = auth_hash[:uid]
    merchant.provider = 'github'
    merchant.username  = auth_hash['info']['name']
    merchant.email = auth_hash['info']['email']

    return merchant
  end

end
