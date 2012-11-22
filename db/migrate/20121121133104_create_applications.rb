class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.string :position
      t.text :text

      t.timestamps
    end
  end
end
