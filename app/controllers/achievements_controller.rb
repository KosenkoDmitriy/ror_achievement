# frozen_string_literal: true

class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @achievements = Achievement.public_access #.where(privacy: :public_access)
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
    @achievement = Achievement.new(achievement_params)
    @achievement.user = current_user
    if @achievement.save
      UserMailer.achievement_created(current_user.email, @achievement.id).deliver_now
      redirect_to achievement_url(@achievement), notice: 'Achievement has been created'
    else
      # notice = @achievement.errors.messages.map { |msg| msg }.join(' ') # lowercase
      notice = @achievement.errors.full_messages.join(' ') # capitalize
      # notice = @achievement.errors.messages.map { |k, v| "#{k}: #{v.split(',').join(' & ')}" }.join("; ") #{ |k,v| "#{k}: #{v}" }.join(";") # custom with ; and & delimitters
      flash[:error] = notice
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
