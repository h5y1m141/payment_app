desc 'API Routes with Grape'
task swagger_routes: :environment do
  Api.routes.each do |api|
    # rake routesと似たような表示フォーマットにしたいのでljustを利用
    # https://docs.ruby-lang.org/ja/latest/method/String/i/ljust.html
    method = api.request_method.ljust(10)
    path = api.path
    puts "     #{method} #{path}" unless path.include?('swagger_doc')
  end
end
