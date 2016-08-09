require 'rails_helper'

RSpec.describe Web::TasksController, :type => :controller do
  describe "GET index" do
    context "user authenticated" do

      # it "renders the index template" do
      #   get :index
      #   expect(response).to render_template("index")
      # end
    end
    context "user not authenticated" do
      it "redirects user to login_path" do
        get :index
        expect(response).to redirect_to login_path
      end
    end

  end
end
