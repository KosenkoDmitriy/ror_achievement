# frozen_string_literal: true

class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @achievements = Achievement.get_public_achievements
  end

  def edit
  end

  def update
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_url(@achievement)
    else
      render :edit
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_url
  end

  def new
    @achievement = Achievement.new
  end

  def create
    service = CreateAchievement.new(achievement_params, current_user)
    service.create
    if service.created?
      redirect_to achievement_path(service.achievement)
    else
      @achievement = service.achievement
      render :new
    end
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  private

  def achievement_params
    params.require(:achievement).permit(:id, :title, :description, :privacy, :cover_image, :featured)
  end

  def owners_only
    @achievement = Achievement.find(params[:id])
    if current_user != @achievement.user
      redirect_to achievements_path
    end
  end
end
