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
FactoryBot.define do
  factory :timesheet do
    date { "2021-08-14" }
    start_time { "2021-08-14 09:29:31" }
    finish_time { "2021-08-14 09:29:31" }
  end
end
