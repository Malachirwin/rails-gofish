require "rails_helper"

RSpec.describe "routes for Sessions", type: :routing do
  it "routes / to the sessions controller/new" do
    expect(get("/")).to route_to("sessions#new")
  end

  it "routes /login to the sessions/new controller" do
    expect(get("/login")).to route_to("sessions#new")
  end

  it "routes /logout to the sessions/destroy controller" do
    expect(delete("/logout")).to route_to("sessions#destroy")
  end

  it "routes /game to the sessions/destroy controller" do
    expect(get("sessions/game")).to route_to("sessions#game")
  end

  it "routes /create_game to the sessions/destroy controller" do
    expect(get("sessions/create_game")).to route_to("sessions#create_game")
  end
end