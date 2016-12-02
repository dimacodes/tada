class CreateNothings < ActiveRecord::Migration[5.0]
  def change
      create_table :nothings do |t|
        t.string :no_title
        t.string :no_content
        t.integer :user_id
      end
    end
  end
