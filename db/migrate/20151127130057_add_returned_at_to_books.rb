class AddReturnedAtToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :returned_at, :datetime
  end
end
