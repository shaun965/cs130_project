class CreateDrScores < ActiveRecord::Migration[5.1]
  def change
    create_table :dr_scores do |t|
      t.integer :left_score
      t.integer :right_score
      t.string :left_photo
      t.string :right_photo
      t.string :left_note
      t.string :right_note
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
