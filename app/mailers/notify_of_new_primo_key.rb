class NotifyOfNewPrimoKey < ActionMailer::Base
  default from: "from@example.com"


  def new_primo_key(primo_display_field)
    @primo_display_field = primo_display_field
    mail(to: 'jhartzle@nd.edu, jkennel@nd.edu, rfox2@nd.edu', subject: "New KEY, #{primo_display_field.key} now available from Primo!!!!!!")
  end
end
