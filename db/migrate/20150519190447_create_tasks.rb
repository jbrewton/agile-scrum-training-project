class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :action_item

      t.timestamps null: false
    end
  end
end
