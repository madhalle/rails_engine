class Api::V1::Merchants::BusinessIntelController < ApplicationController
  def index
    merchant = Merchant.most_revenue(revenue_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
