# frozen_string_literal: true

class ChangeDriverIdAndAssignedAtNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:taxi_requests, :driver_id, true)
    change_column_null(:taxi_requests, :assigned_at, true)
  end
end
