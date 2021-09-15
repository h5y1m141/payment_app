class UserProfile < ApplicationRecord
  belongs_to :user

  def full_name
    last_name + first_name
  end
end
