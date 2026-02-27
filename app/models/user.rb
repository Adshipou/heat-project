class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

  after_create :promote_first_user_to_super_admin
  before_save :ensure_super_admin_is_admin
  after_commit :sync_linked_member_executive_status, if: :saved_change_to_admin?

  def admin?
    admin
  end

  def super_admin?
    super_admin
  end

  def linked_member
    Member.find_by(member_name: full_name)
  end

  def self.from_omniauth(auth)
    return nil if auth.blank?

    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      #user.skip_confirmation!
    end

    user.ensure_member_profile!
    user
  end

  def ensure_member_profile!
    normalized_name = full_name.to_s.strip
    return if normalized_name.blank?
    return if Member.exists?(member_name: normalized_name)

    Member.create!(
      member_name: normalized_name,
      member_points: 0,
      executive_status: admin?
    )
  end

  private

  # Demo-friendly default: the first account to sign in becomes super admin.
  def promote_first_user_to_super_admin
    return unless User.count == 1

    update_columns(admin: true, super_admin: true, updated_at: Time.current)
    sync_linked_member_executive_status
  end

  def ensure_super_admin_is_admin
    self.admin = true if super_admin?
  end

  def sync_linked_member_executive_status
    member = linked_member
    return unless member.present?

    desired_executive_status = admin?
    return if member.executive_status == desired_executive_status

    member.update_columns(executive_status: desired_executive_status, updated_at: Time.current)
  end
end

