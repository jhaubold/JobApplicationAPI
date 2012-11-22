# encoding: UTF-8
class ApplicationMailer < ActionMailer::Base
  default from: "api-anmeldung@megorei.com"
  def api_application(user)
    @user = user
    @url  = "http://megorei.com/api/"
    mail(:to => user.email, :subject => "API-Anmeldung bei megorei.com")
  end

  def thanks_for_application(user) 
  	@user = user
  	mail(:to => user.email, :subject => "Vielen Dank für Ihre Bewerbung")
  end

  def new_application(application)
  	@application = application
  	mail(:to => "new_applications@megorei.com", :subject => "Eine neue Bewerbung ist eingetroffen")
  end
  
end
