class CreateEventsMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :events_members do |t|
      t.references :event, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
