class AddSuperAdminToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :super_admin, :boolean, default: false, null: false
    add_index :users, :super_admin

    first_user_id = select_value("SELECT id FROM users ORDER BY id ASC LIMIT 1")
    if first_user_id.present?
      execute("UPDATE users SET super_admin = 1, admin = 1 WHERE id = #{first_user_id}")
    end

    execute(<<~SQL)
      UPDATE users
      SET admin = 1
      WHERE full_name IN (
        SELECT member_name
        FROM members
        WHERE executive_status = 1
      )
    SQL

    execute(<<~SQL)
      UPDATE members
      SET executive_status = 1
      WHERE member_name IN (
        SELECT full_name
        FROM users
        WHERE admin = 1
      )
    SQL
  end

  def down
    remove_index :users, :super_admin
    remove_column :users, :super_admin
  end
end
