class CreateBooks < ActiveRecord::Migration[6.1]
  def self.up
    create_table(:books) do |t|
      t.column :name, :string, limit: 100, null: false
      t.column :synopsis, :string
      t.column :probation, :text
      t.column :author_id, :integer, null: false
      t.timestamps
    end
  end

  def self.down
    drop_table(:books)
  end
end
