class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :location_code
      t.string :city
      t.string :foto

      t.timestamps
    end
  end
end
