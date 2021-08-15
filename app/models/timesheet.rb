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
  include WorkingTimes::Calculation

  belongs_to :user

  validates :date, :start_time, :finish_time, presence: true
  validate :time_working, :date_working

  private

  def date_working
    return unless date

    errors.add(:date, ' working can not be in the future.') if date > Date.today
  end

  def time_working
    return unless start_time || finish_time
    
    errors.add(:finish_time, 'always greater than or equal Start time.') if start_time > finish_time
  end
end
