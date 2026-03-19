require "rails_helper"

RSpec.describe "Basic flows", type: :request do
  it "home page loads" do
    get root_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("FretaGo")
  end
end


