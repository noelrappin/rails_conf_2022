class CardOrderChangesController < ApplicationController
  def update
    @card = Card.find(params[:id])
    @card.insert_at(params[:position].to_i)
    @card.save!
    head :ok
  end
end
