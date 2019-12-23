class RemoveRequestedAtOfTaxiRequests < ActiveRecord::Migration[6.0]
  def up
    remove_column :taxi_requests, :requested_at
  end
end
