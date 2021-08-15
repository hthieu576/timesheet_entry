# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkingTimes::Calculation, type: :model do
  describe '#earning_daily' do
    let(:user) { create(:user) }
    let(:timesheet) { create(:timesheet, user: user, date: date, start_time: start_time, finish_time: finish_time) }

    subject { timesheet.earning_daily(timesheet.date, timesheet.start_time, timesheet.finish_time) }

    context 'with case weekend' do
      let(:date) { '15/08/2021' } # sunday
      let(:start_time) { '15:30' }
      let(:finish_time) { '20:00' }

      it 'response format!' do
        expect(subject).to eq 211.5
      end
    end

    context 'with case monday, wednesday, friday' do
      let(:date) { '09/08/2021' } # monday
      let(:start_time) { '10:00' }
      let(:finish_time) { '17:00' }

      it 'response format!' do
        expect(subject).to eq 154.0
      end
    end

    context 'with case monday, wednesday, friday' do
      let(:date) { '11/08/2021' } # wednesday
      let(:start_time) { '04:00' }
      let(:finish_time) { '21:30' }

      it 'response format!' do
        expect(subject).to eq 451.0
      end
    end

    context 'with case monday, wednesday, friday' do
      let(:date) { '11/08/2021' } # wednesday
      let(:start_time) { '02:00' }
      let(:finish_time) { '06:00' }

      it 'response format!' do
        expect(subject).to eq 136.0
      end
    end

    context 'with case tuesday, thursday' do
      let(:date) { '10/08/2021' } # tuesday
      let(:start_time) { '12:00' }
      let(:finish_time) { '20:15' }

      it 'response format!' do
        expect(subject).to eq 238.75
      end
    end
  end
end
