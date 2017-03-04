VCR.configure do |c|
  # the directory where all VCR cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  
  # https://relishapp.com/vcr/vcr/docs/configuration/hook-into
  c.hook_into :webmock

  # ignore localhost interactions ie all tests that have `js: true` / AJAX
  # https://github.com/vcr/vcr/issues/317#issuecomment-23322940
  c.ignore_localhost = true
end
