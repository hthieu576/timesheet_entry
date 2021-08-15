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
    user
    date { Date.today }
    start_time { Time.parse('10:00') }
    finish_time { Time.parse('18:00') }
  end
end
