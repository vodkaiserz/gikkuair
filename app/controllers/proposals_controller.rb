class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end
  def create
    @proposal = Proposal.new(proposal_params)

    if @proposal.valid?
      ProposalMailer.message_me(@proposal).deliver_now
      redirect_to new_proposal_path, notice: "Thankyou for your proposal."
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :email, :subject, :content)
  end
end