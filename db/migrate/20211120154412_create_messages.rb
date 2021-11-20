class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content, :limit => 4294967295
      t.integer :status, default: 1 # 1=>public 2=>prive
      t.integer :actif, default: 1  # 1=>actif 2=>archive
      t.references :transmitter, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
