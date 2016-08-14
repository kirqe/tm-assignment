require "rails_helper"

RSpec.describe Web::Admin::Dashboard::TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/dashboard/tasks").to route_to("web/admin/dashboard/tasks#index")
    end

    it "routes to #show" do
      expect(get: "/admin/dashboard/tasks/1").to route_to("web/admin/dashboard/tasks#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/dashboard/tasks/1/edit").to route_to("web/admin/dashboard/tasks#edit", id: "1")
    end

    it "routes to #new" do
      expect(get: "/admin/dashboard/tasks/new").to route_to("web/admin/dashboard/tasks#new")
    end

    it "routes to #create" do
      expect(post: "/admin/dashboard/tasks").to route_to("web/admin/dashboard/tasks#create")
    end

    it "routes to #update" do
      expect(put: "/admin/dashboard/tasks/1").to route_to("web/admin/dashboard/tasks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/dashboard/tasks/1").to route_to("web/admin/dashboard/tasks#destroy", id: "1")
    end
  end
end
