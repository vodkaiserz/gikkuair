class ProposalMailer < ApplicationMailer
 default :to => "daniel.ellias.saputro@gmail.com"
  def message_me(msg)
  	@msg = msg
    mail subject: "New Request Quotation"
  end
end
