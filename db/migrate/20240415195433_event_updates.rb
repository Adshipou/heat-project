class EventUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_end, :datetime
    add_column :events, :event_points, :integer
  end
end
