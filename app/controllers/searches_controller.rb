class SearchesController < ApplicationController
  before_filter :only_customer

  def show
    @search = Search.new params[:search]
  end

  private

  def only_customer
    unless current_user.customer?
      flash[:danger] = 'You must be a customer to search for workers'
      redirect_to dashboard_path
    end
  end
end
