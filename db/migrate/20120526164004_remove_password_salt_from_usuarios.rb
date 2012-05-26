class RemovePasswordSaltFromUsuarios < ActiveRecord::Migration
  def up
    remove_column :usuarios, :password_salt
  end

  def down
    add_column :usuarios, :password_salt, :string
  end
end
