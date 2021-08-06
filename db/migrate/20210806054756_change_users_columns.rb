class ChangeUsersColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :text
    remove_column :users, :password, :text
  end
end
