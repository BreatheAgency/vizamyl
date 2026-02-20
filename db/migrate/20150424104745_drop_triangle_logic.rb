class DropTriangleLogic < ActiveRecord::Migration
  def change
    remove_column :users, :black_triangle_viewed_at
  end
end
