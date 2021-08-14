json.extract! timesheet, :id, :date, :start_time, :finish_time, :created_at, :updated_at
json.url timesheet_url(timesheet, format: :json)
