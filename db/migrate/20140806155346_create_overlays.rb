class CreateOverlays < ActiveRecord::Migration
  def change
    create_table :overlays do |t|

      t.timestamps
    end
  end
end
