# spec/controllers/calculator_controller_spec.rb
require 'rails_helper'

RSpec.describe CalculatorController, type: :controller do
  describe "POST #add" do
    context "with valid input" do
      it "returns 0 for a string" do
        post :add, params: { numbers: "" }
        expect(assigns(:sum)).to eq(0)
      end
      it "returns the correct sum for a single number" do
        post :add, params: { numbers: "5" }
        expect(assigns(:sum)).to eq(5)
      end

      it "returns the correct sum for two numbers" do
        post :add, params: { numbers: "2,3" }
        expect(assigns(:sum)).to eq(5)
      end

      it "returns the correct sum for multiple numbers" do
        post :add, params: { numbers: "1,2,3,4,5" }
        expect(assigns(:sum)).to eq(15)
      end

      it "handles new lines between numbers" do
        post :add, params: { numbers: "1\n2,3" }
        expect(assigns(:sum)).to eq(6)
      end

      it "supports different delimiters" do
        post :add, params: { numbers: "//;\n1;2;3" }
        expect(assigns(:sum)).to eq(6)
      end
    end

    context "with invalid input" do
      it "returns a bad request status for negative numbers" do
        post :add, params: { numbers: "1,-2,3" }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
