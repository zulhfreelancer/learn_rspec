class PhonesController < ApplicationController
  
  def show
  	@phone = Phone.find(params[:id])
  end

end
