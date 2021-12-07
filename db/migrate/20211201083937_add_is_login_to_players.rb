class AddIsLoginToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :is_login, :boolean
  end
end
