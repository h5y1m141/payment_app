# https://jamesnewton.com/blog/how-i-test-graphql-in-rails-with-rspec
module GraphQLHelpers
  def controller
    @controller ||= Admin::Api::V1::GraphqlController.new.tap do |obj|
      obj.set_request! ActionDispatch::Request.new({})
    end
    # Content-Typeを設定しないとMutationのvariablesの処理が期待通りにならないケースあるため必要
    @headers = { 'Content-Type' => 'application/json' }
  end

  def execute_graphql(query, **kwargs)
    Admin::V1::PaymentAppSchema.execute(
      query,
      { context: { controller: controller } }.merge(kwargs)
    )
  end
end

RSpec.configure do |c|
  c.include GraphQLHelpers, type: :graphql
end
