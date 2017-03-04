class AddImageToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :image, :string
  end
end
