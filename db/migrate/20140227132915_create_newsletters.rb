class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|

      t.timestamps
    end
  end
end
