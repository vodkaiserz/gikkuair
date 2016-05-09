class ProposalMailer < ApplicationMailer
 default :to => "daniel.ellias.saputro@gmail.com"
  def message_me(msg)
  	@msg = msg

    mail from: @msg.email, subject: @msg.subject, body: @msg.content
  end
end
