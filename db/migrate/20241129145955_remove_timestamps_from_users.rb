class RemoveTimestampsFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :created_at, :datetime
    remove_column :users, :updated_at, :datetime
  end
end
