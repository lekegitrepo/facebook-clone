class AddIndicesToFriendship < ActiveRecord::Migration[6.0]
	def change
		add_index :friendships, :user_id
		add_index :friendships, :friend_id
		add_index :friendships, [:user_id, :friend_id], unique: true
	end
end
