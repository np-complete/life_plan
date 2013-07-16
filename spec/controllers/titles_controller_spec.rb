# -*- coding: utf-8 -*-
require 'spec_helper'

describe TitlesController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "assigns ids of watching title as @watching_ids" do
      titles = [
        FactoryGirl.create(:title, :kana => 'あああ'),
        FactoryGirl.create(:title, :kana => 'いいい')
      ]
      others = FactoryGirl.create(:title, :kana => 'かかか')
      FactoryGirl.create(:watching, user: @user, title: titles.first)
      FactoryGirl.create(:watching, user: @user, title: others)
      get :index, :initial => 'あ'
      expect(assigns(:watching_ids)).to eq [titles.first.id]
    end

    context :current do
      it "assigns unfinished titles as @titles" do
        titles = FactoryGirl.create_list(:title, 3, finished_at: nil)
        finished_titles = FactoryGirl.create_list(:title, 3, finished_at: Time.now.beginning_of_year)
        get :index
        expect(assigns(:titles)).to eq titles
      end
    end

    context :all do
      it "assigns all titles as @titles" do
        titles = FactoryGirl.create_list(:title, 9, finished_at: Time.now.beginning_of_year)
        get :index, :initial => 'all'
        expect(assigns(:titles)).to eq titles.sort_by(&:kana)
      end
    end

    context :with_initial do
      it "assigns matched titles as @titles" do
        titles = [
          FactoryGirl.create(:title, :kana => 'あああ'),
          FactoryGirl.create(:title, :kana => 'いいい')
        ]
        others = FactoryGirl.create(:title, :kana => 'かかか')
        get :index, :initial => 'あ'
        expect(assigns(:titles)).to eq titles
      end
    end
  end

  describe :update do
    it "create watching" do
      title = FactoryGirl.create(:title)
      put :update, :id => title.id
      expect(Watching.where(:user_id => @user.id, :title_id => title.id).exists?).to be_true
    end
  end

  describe :destroy do
    it "create user_channel" do
      watching = FactoryGirl.create(:watching, user: @user)
      delete :destroy, :id => watching.title_id
      expect(Watching.where(:user_id => @user.id, :title_id => watching.title_id).exists?).to be_false
    end
  end
end
