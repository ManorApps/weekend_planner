class EventsController < ApplicationController
  before_action :logged_in?
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    #@events = Event.joins(:attending, :user).select('users.first_name', 'users.last_name', 'events.name', 'events.description','events.start_date','events.end_date','events.created_at', 'events.id').where('attendings.user_id' => session[:user_id]).distinct
    @events = User.find(session[:user_id]).events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @this_event_id = params[:id]
    @this_user_id = session[:user_id]
    @is_this_user_attending = Attending.select('attendings.id').where('attendings.user_id' => @this_user_id, 'attendings.event_id' => @this_event_id)
    # @attendees = Attending.joins(:user).select('users.id', 'users.first_name', 'users.last_name', 'users.email').where('attendings.event_id' => @this_event_id)
    @attendees = @event.users

  end

  # GET /events/new
  def new
    @event = Event.new
    @user_id = session[:user_id]
  end

  # GET /events/1/edit
  def edit
    @user_id = session[:user_id]
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        @attending = Attending.new
        @attending.event_id = @event.id
        @attending.user_id = session[:user_id]
        @attending.save
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend
    @attending = Attending.new
    @attending.event_id = params[:id]
    @attending.user_id = session[:user_id]
    @attending.save
    redirect_to :action => "show", :id => params[:id]

  end

  def unattend
    @unattending = Attending.find_by(user_id: session[:user_id], event_id: params[:id]).destroy
    redirect_to :action => "show", :id => params[:id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by("token = ?", params[:token])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :created_by)
    end
end
