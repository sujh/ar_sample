class CreateAuthor < ActiveRecord::Migration[6.1]
  def self.up
    create_table(:authors) do |t|
      t.column :name, :string, limit: 30, null: false
      t.column :birth, :smallint
      t.column :gender, :boolean
      t.column :country, :string
      t.timestamps
    end
  end

  def self.down
    drop_table(:authors)
  end
end
