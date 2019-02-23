class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    #head :no_content
    render json: {
      status: 200,
      message: "Logged out successfully.",
    }.to_json
  end
end