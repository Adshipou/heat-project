class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :member_name
      t.integer :member_points
      t.boolean :executive_status

      t.timestamps
    end
  end
end
