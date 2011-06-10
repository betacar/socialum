class DeviseCreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios, :id => false do |t|
      t.integer :id, :null => false
      t.references :estado, :null => false, :default => 1
      t.ldap_authenticatable #, :null => false
      t.rememberable
      t.trackable

      t.timestamps
    end

    add_index :usuarios, :login, :unique => true
    execute "ALTER TABLE usuarios ADD PRIMARY KEY (id);"
  end

  def self.down
    drop_table :usuarios
  end
end
