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

  ROLE = {
    normal: "Normal",
    admin: "Admin"
  }
  # admin? 判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end
end
