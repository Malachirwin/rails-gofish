require "rails_helper"

RSpec.describe "routes for Sessions", type: :routing do
  it "routes / to the sessions controller/new" do
    expect(get("/")).to route_to("sessions#new")
  end
end
