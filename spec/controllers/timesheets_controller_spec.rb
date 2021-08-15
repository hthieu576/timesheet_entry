require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  before do
    user = create(:user)
    sign_in(user)
  end

  describe 'GET /timesheets' do
    subject do
      get :index
      response
    end

    it 'requests successfly' do
      subject
      expect(response.status).to eq 200
    end
  end

  describe 'GET /timesheets/new' do
    subject do
      get :new
      response
    end

    it 'requests successfly' do
      subject
      expect(response.status).to eq 200
    end
  end

  describe 'POST /timesheets' do
    let(:params) do
      {
        timesheet: {
          date: date,
          start_time: '10:00',
          finish_time: '22:00'
        }
      }
    end

    subject do
      post :create, params: params
      response
    end

    context 'when case failed' do
      context 'when case date nil' do
        let(:date) { nil }

        it 'unprocessable!' do
          subject
          expect(response.status).to eq 422
        end
      end

      context 'when case start_time greater than finish_time' do
        let(:params) do
          {
            timesheet: {
              date: Date.today - 1.days,
              start_time: '13:00',
              finish_time: '10:00'
            }
          }
        end

        it 'unprocessable!' do
          subject
          expect(response.status).to eq 422
        end
      end
    end

    context 'when case success' do
      let(:date) { Date.today - 1.days }

      it 'should create a record!' do
        expect { subject }.to change(Timesheet, :count).from(0).to(1)
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET /timesheets/:id/edit' do
    subject do
      get :edit, params: { id: timesheet.id }
      response
    end

    before do
      sign_in(user)
    end

    let(:user) { create(:user) }

    context 'when case not authorization' do
      let(:timesheet) { create(:timesheet) }

      it 'can not access' do
        subject
        expect(response.status).to eq 302
      end
    end

    context 'when case authorization' do
      let(:timesheet) { create(:timesheet, user: user) }

      it 'can access' do
        subject
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /timesheets/:id' do
    subject do
      get :show, params: { id: timesheet.id }
      response
    end

    before do
      sign_in(user)
    end

    let(:user) { create(:user) }

    context 'when case not authorization' do
      let(:timesheet) { create(:timesheet) }

      it 'can not access' do
        subject
        expect(response.status).to eq 302
      end
    end

    context 'when case authorization' do
      let(:timesheet) { create(:timesheet, user: user) }

      it 'can access' do
        subject
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PUT /timesheets/:id' do

    subject do
      put :update, params: params
      response
    end

    before do
      sign_in(user)
    end

    let(:user) { create(:user) }
    let(:timesheet) { create(:timesheet, user: user) }

    context 'when case valid params' do
      let(:params) do
        { id: timesheet.id,
          timesheet: {
            date: Date.today - 2.days,
          }
        }
      end

      it 'should update date of record!' do
        expect { subject }.to change { timesheet.reload.date }.from(Date.today).to(Date.today - 2.days)
      end
    end

    context 'when case invalid params' do
      let(:params) do
        { id: timesheet.id,
          timesheet: {
            date: ''
          }
        }
      end

      it 'unprocessable!' do
        subject
        expect(response.status).to eq 422
      end
    end

    context 'when case not found timesheet' do
      let(:params) do
        { id: 99999,
          timesheet: {
            date: Date.today - 2.days,
          }
        }
      end

      it 'raise not found error!' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE /timesheets/:id' do
    subject do
      delete :destroy, params: { id: timesheet.id }
      response
    end

    before do
      sign_in(user)
    end

    let(:user) { create(:user) }

    let(:timesheet) { create(:timesheet, user: user) }

    it 'should delete a record!' do
      expect { subject }.to change(Timesheet, :count).by(0)
    end
  end
end