require "rails_helper"

RSpec.describe Web::Admin::Dashboard::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/dashboard/users").to route_to("web/admin/dashboard/users#index")
    end

    it "routes to #show" do
      expect(get: "/admin/dashboard/users/1").to route_to("web/admin/dashboard/users#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/dashboard/users/1/edit").to route_to("web/admin/dashboard/users#edit", id: "1")
    end

    it "routes to #new" do
      expect(get: "/admin/dashboard/users/new").to route_to("web/admin/dashboard/users#new")
    end

    it "routes to #create" do
      expect(post: "/admin/dashboard/users").to route_to("web/admin/dashboard/users#create")
    end

    it "routes to #update" do
      expect(put: "/admin/dashboard/users/1").to route_to("web/admin/dashboard/users#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/dashboard/users/1").to route_to("web/admin/dashboard/users#destroy", id: "1")
    end
  end
end
