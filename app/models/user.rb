class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法

  # 加上驗證 name 不能重覆
  validates_uniqueness_of :name, :case_sensitive => true
  validates_presence_of :name


  has_many :dojos, dependent: :destroy
  has_many :comments, dependent: :destroy


  #「使用者收藏很多文章」的多對多關聯
  has_many :collects, dependent: :destroy
  has_many :collected_dojos, through: :collects, source: :dojo

  has_many :vieweds, dependent: :destroy
  has_many :viewed_dojos, through: :vieweds, source: :dojo

  #has_many :friendships, -> {where accepted: true}, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { accepted: true } ) } , through: :friendships
  #我加的但對方還沒接受
  has_many :friends_not_acceted, -> { where(friendships: { accepted: false } ) } , through: :friendships, source: :friend

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, -> { where(friendships: { accepted: true } ) }, through: :inverse_friendships , source: :user
  #加我但我還沒回應
  has_many :friends_not_responded, -> { where(friendships: { accepted: false } ) }, through: :inverse_friendships , source: :user


  before_create :generate_authentication_token

  ROLE = {
    normal: "Normal",
    admin: "Admin"
  }
  # admin? 判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  def friend?(user)
    self.friends.include?(user) || self.inverse_friends.include?(user)
  end

  def is_not_accepted_by?(user)
    self.friends_not_acceted.include?(user)
  end

  def is_not_responded_to?(user)
    self.friends_not_responded.include?(user)
  end

  def has_friendships?(user)
    if self.friend?(user)
      return true
    else
      if self.is_not_accepted_by?(user)
        return true
      else
        return false
      end
    end
  end



  #我加的人和加我的人
  def all_friends
    friends = self.friends + self.inverse_friends
    return friends.uniq
  end

  def create_friendships(user)
    if not self.has_friendships?(user)
      if user.has_friendships?(self)
        @friendship = user.friendships.find_by(friend_id: self.id)
        if @friendship
          @friendship.update(accepted: true)
        end
      else
        @friendship = self.friendships.build(friend_id: user.id)
        @friendship.save
      end
    end
  end



  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end
