class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :micropost_id
      t.integer :user_id

      t.timestamps
    end
    add_index :retweets, :micropost_id
    add_index :retweets, :user_id
    add_index :retweets, [:micropost_id, :user_id], unique: true
  end
end
