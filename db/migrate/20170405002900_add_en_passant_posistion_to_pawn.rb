class AddEnPassantPosistionToPawn < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :en_passant_x, :integer
    add_column :pieces, :en_passant_y, :integer
  end
end
