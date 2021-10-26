module Admin
  module Api
    module V1
      class GraphqlController < ApplicationController
        protect_from_forgery with: :null_session

        def execute
          variables = prepare_variables(params[:variables])
          query = params[:query]
          operation_name = params[:operationName]
          context = {
            # Query context goes here, for example:
            # current_user: current_user,
          }
          result = Admin::V1::PaymentAppSchema.execute(query, variables: variables, context: context,
                                                              operation_name: operation_name)
          render json: result
        rescue StandardError => e
          raise e unless Rails.env.development?

          handle_error_in_development(e)
        end

        private

        # Handle variables in form data, JSON body, or a blank value
        def prepare_variables(variables_param) # rubocop:disable Metrics/MethodLength
          case variables_param
          when String
            if variables_param.present?
              JSON.parse(variables_param) || {}
            else
              {}
            end
          when Hash
            variables_param
          when ActionController::Parameters
            variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
          when nil
            {}
          else
            raise ArgumentError, "Unexpected parameter: #{variables_param}"
          end
        end

        def handle_error_in_development(error)
          logger.error error.message
          logger.error error.backtrace.join("\n")

          render json:
          {
            errors: [
              {
                message: error.message,
                backtrace: error.backtrace
              }
            ],
            data: {}
          },
                 status: :internal_server_error
        end
      end
    end
  end
end
