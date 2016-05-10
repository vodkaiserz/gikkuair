class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end
  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.valid?
      ProposalMailer.message_me(@proposal).deliver_now
      redirect_to :back, notice: "Thankyou for your request of quotation."
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :email, :telnum, :category, :event, :eventmore)
  end

end