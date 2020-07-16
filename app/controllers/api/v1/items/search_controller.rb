class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.attribute_finder(query_params)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.single_attribute_finder(query_params)
    render json: ItemSerializer.new(item.first)
  end


  private
  def query_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
