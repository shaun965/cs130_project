class CreateBloodSugars < ActiveRecord::Migration[5.1]
  def change
    create_table :blood_sugars do |t|
      t.float :number
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
