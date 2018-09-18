class AchievementsController < ApplicationController
  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      # flash[:notice] = "Achievement has been created"
      redirect_to root_url, notice: "Achievement has been created"
    else
      render :new
      # redirect_to root_url, notice: "can't be blank"
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :featured)
  end
end