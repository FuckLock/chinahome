class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.string 'provider', null: false
      t.string 'uid', limit: 1000, null: false
      t.integer 'user_id', null: false
      t.timestamps
    end
  end
end
