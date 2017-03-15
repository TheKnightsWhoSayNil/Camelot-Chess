class Adduseridtopiecesname < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :user_id, :integer
  end
end
