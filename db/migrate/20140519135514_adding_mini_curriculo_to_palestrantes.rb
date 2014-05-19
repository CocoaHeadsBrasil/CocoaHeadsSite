class AddingMiniCurriculoToPalestrantes < ActiveRecord::Migration
  def change
  	add_column :palestrantes, :mini_curriculo, :text
  end
end
