class SessionsController < ApplicationController
  def new
    @meetings = Meeting.all
    @events = Event.all
    @links = Link.all
  end

  def new2
    @meetings = Meeting.all
    @events = Event.all
    @links = Link.all
  end

  def create
    @meetings = Meeting.all
    @events = Event.all
    @links = Link.all
    if params[:password] == 'TxAMHeat#2k13'
      session[:authenticated] = true
      redirect_to root_path, notice: 'Successfully authenticated.'
    else
      flash.now[:alert] = 'Invalid password'
      render :new
    end
  end
end
