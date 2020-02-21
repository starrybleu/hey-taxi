# frozen_string_literal: true

class CreateTaxiRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :taxi_requests do |t|
      t.integer :passenger_id
      t.string :address
      t.datetime :requested_at
      t.integer :driver_id
      t.datetime :assigned_at
      t.timestamps
    end
  end
end
