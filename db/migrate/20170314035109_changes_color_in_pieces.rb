class ChangesColorInPieces < ActiveRecord::Migration[5.0]
  def change
    change_column :pieces, :color, :string
  end
end
