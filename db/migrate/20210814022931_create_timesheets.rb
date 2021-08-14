class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :finish_time, null: false

      t.timestamps
    end
  end
end
