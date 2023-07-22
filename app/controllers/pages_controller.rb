class PagesController < ApplicationController
  def index
    if user_signed_in? == true
      redirect_to publications_path
    end
  end
end
