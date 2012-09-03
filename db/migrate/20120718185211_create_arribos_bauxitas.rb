class CreateArribosBauxitas < ActiveRecord::Migration
  def change
    create_table :arribos_bauxitas do |t|

      t.timestamps
    end
  end
end
