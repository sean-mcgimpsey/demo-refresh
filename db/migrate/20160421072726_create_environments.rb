class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :servername
      t.string :location

      t.timestamps null: false
    end
  end
end
