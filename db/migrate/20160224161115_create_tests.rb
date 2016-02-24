class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :question
      t.boolean :answer

      t.timestamps null: false
    end
  end
end
