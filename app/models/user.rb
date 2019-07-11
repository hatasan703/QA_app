class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :omniauthable
  has_many :questions
  has_many :answers
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9]+\z/i, message: "英数字以外の文字は使用できません" }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "正しいメールアドレスを入力してください" }


  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image:    User.default_image,
        user_name: auth.info.nickname,
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
