class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :palestrante
      t.references :agenda

      t.string  :titulo
      t.text    :descricao
      t.string  :youtube
      t.boolean :published
      t.integer :position

      t.timestamps
    end
  end
end
