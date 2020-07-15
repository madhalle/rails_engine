class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.attribute_finder(query_params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.single_finder(query_params)
    render json: MerchantSerializer.new(merchant.first)
  end

  private
  def query_params
    params.permit(:name, :created_at, :updated_at)
  end

end
