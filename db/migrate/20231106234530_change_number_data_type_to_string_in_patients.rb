class ChangeNumberDataTypeToStringInPatients < ActiveRecord::Migration[5.2]
  def change
    change_column :patients, :number, :string
  end
end
