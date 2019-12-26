class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.datetime :expired_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
