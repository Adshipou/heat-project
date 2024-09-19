require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe 'perform_later' do
    it 'enqueues a job' do
      expect do
        ApplicationJob.perform_later
      end.to have_enqueued_job(ApplicationJob)
    end
  end
end
