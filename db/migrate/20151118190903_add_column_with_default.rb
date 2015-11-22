class AddColumnWithDefault < ActiveRecord::Migration
  def change
    add_column :posts, :rate, :integer, :default => 0
    add_column :posts, :rater, :string
  end
end
