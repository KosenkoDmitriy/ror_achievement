require 'rails_helper'

# describe AchievementsController, type: :controller do
describe AchievementsController do
  describe 'GET new' do
    it 'renders :new template' do
      # get post put delete
      get :new
      expect(response).to render_template(:new)
    end
    it 'assings new Achievement to @achievement' do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end
end
