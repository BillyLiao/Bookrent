class AddRestrictionDateToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :restriction_date, :datetime
  end
end
