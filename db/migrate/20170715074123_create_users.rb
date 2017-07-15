class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login, unique: true
      t.string :password
			
			t.belongs_to :role, :class_name => 'Role'

      t.timestamps
			
#			add_index :login, unique: true
    end
  end
end
