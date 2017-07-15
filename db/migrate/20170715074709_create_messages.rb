class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
			t.belongs_to :sender, class_name: 'User'
			t.belongs_to :reciver, class_name: 'User'

      t.timestamps null: false
    end
  end
end
