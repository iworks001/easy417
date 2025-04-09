class CreateCfGroups < ActiveRecord::Migration[4.2]
  def self.up
    create_table :cf_groups do |t|
      t.string  :name, null: false
      t.integer :custom_field_id, null: false
      t.text    :group_values
      t.timestamps
    end
  end

  def self.down
    drop_table :cf_groups
  end
end

