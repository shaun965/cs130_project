class CreateBloodPressures < ActiveRecord::Migration[5.1]
  def change
    create_table :blood_pressures do |t|
      t.float :high
      t.float :low
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
