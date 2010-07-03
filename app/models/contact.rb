class Contact < ActionMailer::Base

  def contact(subject, from_mail, from_name, content)
     @subject = "#{subject} - Message from ismailov.net website"
     @recipients = 'rustam@ismailov.net'
     @from = "mailer@ismailov.net"
     @sent_on = Time.now

     @subject_template = subject
     @from_name_template = from_name
     @from_mail_template = from_mail
     @message_template = content
     @headers = {}
     @headers['Reply-to'] = "\"#{from_name}\" <#{from_mail}>"
  end


end
