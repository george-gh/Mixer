class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :protocol
      t.string :ip
      t.integer :port
      t.string :url

      t.timestamps
    end
  end
end
