class RemoveImageFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :image, :string
  end
end
