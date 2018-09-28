require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include Rails.application.routes.url_helpers # it seems optional

  let(:achievement_id) { 1 }
  let(:email) { UserMailer.achievement_created('author@email.ru', achievement_id).deliver_now }

  it 'sends achievement created email to author' do
    expect(email.to).to include('author@email.ru')
  end

  it 'has correct subject' do
    expect(email.subject).to eq('Congrats with your new achievement!')
  end

  it 'has achievement link in body message' do
    expect(email.body.to_s).to include(achievement_url(achievement_id))
  end
end
