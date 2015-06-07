# config/initializers/carrierwave.rb
 
CarrierWave.configure do |config|
  
  # For testing, upload files to local `tmp` folder.
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
   # config.fog_credentials = {
    # Configuration for Amazon S3 should be made available through an Environment variable.
    # For local installations, export the env variable through the shell OR
    # if using Passenger, set an Apache environment variable.
    #
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder
 
    # Configuration for Amazon S3
   config.fog_credentials = { 
    provider:               'AWS', 
    aws_access_key_id:      "AKIAINJNEY4727JLRKDQ", 
    aws_secret_access_key:  "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", 
  } 
  config.fog_directory  = 'ghacka'
  config.fog_public     = true 



  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
 
 # config.fog_directory    = ENV['S3_BUCKET_NAME']
  #config.s3_access_policy = :public_read                          # Generate http:// urls. Defaults to :authenticated_read (https://)
  #config.fog_host         = "http://gathsy.s3-eu-west-1.amazonaws.com/"
  end
end
 
