if Rails.env.production?
  CarrierWave.configure do |config|
      config.storage :fog
      config.cache_dir = "#{Rails.root}/tmp/uploads"
      config.fog_credentials = {
        :provider               => 'AWS',       # required
        :aws_access_key_id      => 'AKIAJ7GGLZHB4WVQINYA',       # required
        :aws_secret_access_key  => '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',       # required
        :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
      }
      config.fog_directory  = 'VillageStandAlpha'                     # required
#      config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
#      config.fog_public     = false                                   # optional, defaults to true
      config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage :file
  end

  if Rails.env.test? or Rails.env.cucumber?
      CarrierWave.configure do |config|
        config.storage = :file
        config.enable_processing = false
      end
  end
end
