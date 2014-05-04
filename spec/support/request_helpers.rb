require 'spec_helper'

include Warden::Test::Helpers

module RequestHelpers
  def create_logged_in_user
    user = create(:user)
    sign_in user
  end
end
