class WelcomesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
  	render html: '<div><strong>Welcome to Blazar API,</strong> you need to login to perform any action here.</div>'.html_safe
  end
end
