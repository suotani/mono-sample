require 'rails_helper'
RSpec.describe UsersController, type: :request do
  describe "#index" do
    context "user exist" do
      let!(:users){create_list(:user, 3)}
      it "response success" do
        get "/users"
        expect(response.status).to eq(200)
      end

      it "render users" do
        get "/users"
        users.each do |user|
          expect(response.body).to include user.name
        end
      end

    end

    context "user not exist" do
      it "response success" do
        get "/users"
        expect(response.status).to eq(200)
      end

      it "render users" do
        get "/users"
        expect(response.body).to include "ユーザーが存在しません。"
      end
    end
  end

  describe "#create" do
    context "create success" do
      it "response success" do
        post "/users", params: { user: {name: "aaa"}}
        expect(response).to redirect_to user_path(User.last.id)
      end

      it "create success" do
        expect{
          post "/users", params: { user: {name: "aaa"}}
        }.to change(User, :count).by(1)
      end
    end

    context "validation error" do
      it "response success" do
        post "/users", params: { user: {name: ""}}
        expect(response).to eq(200)
      end

      # it "ユーザーが登録されていないこと" do
      #   post "/users", params: { user: {name: "aa"}}
      #   expect(User.take.name).to eq("aaa")
      # end

      # it "render" do
      #   post "/users", params: { user: {name: "aa"}}
      #   expect(response.body).to include "aaa"
      # end
    end
  end

  describe "#edit" do
    context "request existing user_id " do
      let!(:user){create(:user)}
      it "response success" do
        get "/users/#{user.id}"
        expect(response.status).to eq(200)
      end
      it "render users" do
        get "/users/#{user.id}"
        expect(response.body).to include user.name
      end
    end

    context "request not existing user_id " do
      it "response success" do
        expect{get "/users/0"}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end