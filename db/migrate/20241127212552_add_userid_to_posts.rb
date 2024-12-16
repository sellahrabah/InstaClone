class AddUseridToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :user_id, :string
  end
end
