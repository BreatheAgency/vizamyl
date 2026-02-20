class AddBlackTriangleViewedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :black_triangle_viewed_at, :datetime
  end
end
