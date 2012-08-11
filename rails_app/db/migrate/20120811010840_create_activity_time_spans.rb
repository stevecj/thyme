class CreateActivityTimeSpans < ActiveRecord::Migration
  def change
    create_table :activity_time_spans do |t|
      t.date   :on_date   , :null => false
      t.time   :from_time , :null => false
      t.time   :to_time   , :null => false
      t.string :activity  , :null => false
    end
  end
end
