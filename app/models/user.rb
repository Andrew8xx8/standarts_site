#coding: utf-8
class User < ActiveRecord::Base
  attr_accessor :password

  belongs_to :role
  belongs_to :profile, dependent: :destroy
  belongs_to :company, dependent: :destroy

  has_many :standards, dependent: :destroy
  has_many :drafts, dependent: :destroy
  has_many :session_histories, dependent: :destroy

  before_save :encrypt_password

  def has_password?(submitted_password)
    en_password == encrypt(submitted_password)
  end

  def has_fail_info?
    !((profile) && (company))
  end

  def correct?
    ((profile) && (company))
  end

  def self.authenticate(login, submitted_password)
    user = self.find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def super_admin?
    (role.name.eql?("super")) ? true : false
  end

  def self.super_admin
    self.find_by_role_id(Role.super_role)
  end

  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.en_password = encrypt(password) if !password.blank?
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
