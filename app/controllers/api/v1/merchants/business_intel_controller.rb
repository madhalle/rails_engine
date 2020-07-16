class Api::V1::Merchants::BusinessIntelController < ApplicationController
  def index
    Merchant.most_revenue(revenue_params)
    render json: MerchantSerializer.new(Merchant)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
