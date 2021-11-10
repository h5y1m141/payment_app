require 'administrate/custom_dashboard'

# NOTE: Administrateベースではなく通常のRailsControllerを利用する場合は以下
# https://administrate-demo.herokuapp.com/adding_controllers_without_related_model
class CompleteShippingDashboard < Administrate::CustomDashboard
  resource 'CompleteShipping'
end
