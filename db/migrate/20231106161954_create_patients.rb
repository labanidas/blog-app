class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :number
      t.string :email
      t.date :birthdate

      t.timestamps
    end
  end
end
