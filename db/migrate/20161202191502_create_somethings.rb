class CreateSomethings < ActiveRecord::Migration[5.0]
  def change
      create_table :somethings do |t|
        t.string :some_title
        t.string :some_content
        t.integer :user_id
        t.integer :nothing_id
      end
    end
  end
