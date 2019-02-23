class CreateGraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :graphs do |t|
      t.string :name
      t.float :PI

      t.timestamps
    end
  end
end
