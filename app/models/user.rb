require 'securerandom'

class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :attending
  has_many :events, through: :attending
  before_create :generate_token, unless: :token?

  def to_param
    token
  end

  private
    def generate_token
      self.token = SecureRandom.hex(10)
      loop do
        if User.find_by("token = ?", token)
          self.token = SecureRandom.hex(10)
        else
          break
        end
      end
      self.token
    end
end
