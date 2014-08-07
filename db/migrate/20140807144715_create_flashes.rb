class CreateFlashes < ActiveRecord::Migration
  def change
    create_table :flashes do |t|

      t.timestamps
    end
  end
end
