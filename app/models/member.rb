class Member < ApplicationRecord
  has_many :meetings_members, dependent: :destroy
  has_many :meetings, through: :meetings_members
  has_many :events_members, dependent: :destroy
  has_many :events, through: :events_members

  validates :member_name, presence: true, uniqueness: true

  before_validation :normalize_member_name
  after_commit :sync_linked_user_admin_status, if: :saved_change_to_executive_status?

  def linked_user
    User.find_by(full_name: member_name)
  end

  private

  def normalize_member_name
    self.member_name = member_name.to_s.strip
  end

  def sync_linked_user_admin_status
    user = linked_user
    return unless user.present?

    if user.super_admin? && !executive_status?
      update_columns(executive_status: true, updated_at: Time.current)
      return
    end

    if executive_status?
      return if user.admin?

      user.update_columns(admin: true, updated_at: Time.current)
      return
    end

    return if user.super_admin? || !user.admin?

    user.update_columns(admin: false, updated_at: Time.current)
  end
end
