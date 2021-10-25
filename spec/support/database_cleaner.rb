RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # 複数スレッドでの同時アクセス時の動作確認のテストケースを書きたいため以下参考に設定
  # https://qiita.com/takeyuweb/items/e7261e9274b3b31d933c
  config.before(:each, use_truncation: true) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
