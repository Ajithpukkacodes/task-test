class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  reverse_geocoded_by :latitude, :longitude


  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now rescue nil
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
