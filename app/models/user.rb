class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :omniauthable
  has_many :questions
  has_many :answers

  # def self.find_for_oauth(auth)
  #   user = User.where(uid: auth.uid, provider: auth.provider).first

  #   unless user
  #     user = User.create(
  #       uid:      auth.uid,
  #       provider: auth.provider,
  #       email:    auth.info.email,
  #       password: Devise.friendly_token[0, 20]
  #       image: auth.info.image,
  #     )
  #   end

  #   user
  # end


  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image:    User.default_image,
        nickname: auth.info.nickname,
      )
    end

    user
  end

  private

  def self.default_image
    "https://files-uploader.xzy.pw/upload/20190626132827_5a4a477861.png"
  end
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
