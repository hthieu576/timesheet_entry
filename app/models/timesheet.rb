# == Schema Information
#
# Table name: timesheets
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  date        :date             not null
#  start_time  :time             not null
#  finish_time :time             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Timesheet < ApplicationRecord
  belongs_to :user
end
