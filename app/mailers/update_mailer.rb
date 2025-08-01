class UpdateMailer < ApplicationMailer
  def application_update(user)
    @user = user
    mail(to: @user.email, subject: "Application Update")
  end
end
