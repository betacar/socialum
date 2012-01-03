class AddDeviseAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :encrypted_password, :string
    add_column :usuarios, :password_salt, :string
  end

  def self.down
    remove_column :usuarios, :encrypted_password
    remove_column :usuarios, :password_salt
  end
end
