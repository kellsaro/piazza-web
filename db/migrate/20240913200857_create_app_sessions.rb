class CreateAppSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :app_sessions do |t|
      t.string :token_digest
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
