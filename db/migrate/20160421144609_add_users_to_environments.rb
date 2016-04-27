class AddUsersToEnvironments < ActiveRecord::Migration
  def change
    add_reference :environments, :user, index: true, foreign_key: true
  end
end
