class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.integer :user_id
      t.string  :uid
      t.string  :consumer_key
      t.string  :consumer_secret
      t.string  :access_token
      t.string  :access_token_secret
      t.string  :service_name

      t.timestamps null: false
    end

    add_index :social_profiles, :user_id
    add_index :social_profiles, [:user_id, :service_name], unique: true
  end
end
