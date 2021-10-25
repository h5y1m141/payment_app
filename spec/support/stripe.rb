require 'stripe_mock'

RSpec.configure do |config|
  config.around do |example|
    StripeMock.start
    example.run
    StripeMock.stop
  end
end
