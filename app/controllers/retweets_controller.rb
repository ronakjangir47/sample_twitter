class RetweetsController < ApplicationController
  before_filter :signed_in_user, only: :create

  def create
    @micropost_id = params[:retweet][:micropost_id]
    current_user.retweet!(@micropost_id)
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
