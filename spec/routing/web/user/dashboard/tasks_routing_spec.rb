require "rails_helper"

RSpec.describe Web::User::Dashboard::TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dashboard/tasks").to route_to("web/user/dashboard/tasks#index")
    end

    it "routes to #show" do
      expect(get: "/dashboard/users/1/tasks/1").to route_to("web/user/dashboard/tasks#show", user_id: "1", id: "1")
    end

    it "routes to #new" do
      expect(get: "/dashboard/users/1/tasks/new").to route_to("web/user/dashboard/tasks#new", user_id: "1")
    end

    it "routes to #create" do
      expect(post: "/dashboard/users/1/tasks").to route_to("web/user/dashboard/tasks#create", user_id: "1")
    end
  end
end
