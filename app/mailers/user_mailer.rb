class UserMailer < ApplicationMailer
  def achievement_created(email, achievement_id)
    @achievement_id = achievement_id
    mail to: email, subject: 'Congrats with your new achievement!' #, body: "body: #{achievement_url(achievement_id)}"
  end
end
