VCR.configure do |c|
  # the directory where all VCR cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  
  # https://relishapp.com/vcr/vcr/docs/configuration/hook-into
  c.hook_into :webmock
end
