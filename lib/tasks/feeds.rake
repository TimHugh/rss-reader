namespace :feeds do
  task update: :environment do
    UpdateFeedsJob.perform_later
  end
end
