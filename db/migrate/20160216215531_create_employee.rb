class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.decimal :total_earnings, :precision => 14, :scale => 2
      t.string :title

      t.timestamps
    end
  end
end
