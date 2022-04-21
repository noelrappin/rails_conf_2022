class CardAdvancesController < ApplicationController
  def create
    @card = Card.find(params[:id])
    @card.advance
  end

  def destroy
    @card = Card.find(params[:id])
    @card.retreat
  end
end
