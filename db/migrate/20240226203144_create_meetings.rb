class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end