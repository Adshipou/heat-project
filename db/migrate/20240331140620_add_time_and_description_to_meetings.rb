class AddTimeAndDescriptionToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :time, :time
    add_column :meetings, :description, :text
  end
end
