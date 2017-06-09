class AddDetailToPatient < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :name, :string
    add_column :patients, :birthdate, :date
    add_column :patients, :height, :float
    add_column :patients, :weight, :float
    add_column :patients, :sex, :string
  end
end
