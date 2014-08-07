class CreateOutputStreams < ActiveRecord::Migration
  def change
    create_table :output_streams do |t|

      t.timestamps
    end
  end
end
