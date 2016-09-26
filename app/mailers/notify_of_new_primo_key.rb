class NotifyOfNewPrimoKey < ActionMailer::Base
  default from: "discover-notifier@library.nd.edu"


  def new_primo_key(primo_display_field)
    @primo_display_field = primo_display_field
    mail(to: 'jhartzle@nd.edu', subject: "New KEY, #{primo_display_field.key} now available from Primo!!!!!!")
  end
end
