class CreateMeetingsMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_members do |t|
      t.references :meeting, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
