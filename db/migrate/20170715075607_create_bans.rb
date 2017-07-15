class CreateBans < ActiveRecord::Migration
  def change
    create_table :bans do |t|
			t.references :user, index: true

      t.timestamps
    end
  end
end
