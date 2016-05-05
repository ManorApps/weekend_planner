class Event < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "created_by"
  has_many :attending,  dependent: :destroy
  has_many :users, through: :attending
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
