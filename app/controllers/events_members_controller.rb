require 'axlsx'

class EventsMembersController < ApplicationController
  before_action :set_event_member, only: %i[show edit update destroy]
  before_action :require_login
  before_action :require_admin!, except: %i[index create]

  def require_login
    redirect_to login2_path unless session[:authenticated]
  end

  # GET /events_members
  def index
    @events = Event.all
    if admin_view_mode?
      @events_members = EventsMember.includes(:event, :member).all
      @members = Member.all
    else
      @current_member = Member.find_by(member_name: current_user&.full_name)
      @events_members = if @current_member.present?
                          EventsMember.includes(:event, :member).where(member_id: @current_member.id)
                        else
                          EventsMember.none
                        end
      @members = @current_member.present? ? [@current_member] : []
    end
  end

  # for exporting table data
  def export
    @events = Event.order(event_datetime: :desc)
    package = Axlsx::Package.new
    wb = package.workbook
    wb.add_worksheet(name: 'Event Attendance') do |sheet|
      sheet.add_row %w[Date Event Members]
      @events.each do |event|
        event_members = event.events_members
        members_list = event_members.any? ? event_members.map { |em| em.member.member_name }.join(', ') : 'No attendees yet'
        sheet.add_row [event.event_datetime.strftime('%B %d, %Y'), event.event_name, members_list]
      end
    end

    send_data package.to_stream.read, filename: 'event_attendance.xlsx', type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end

  # GET /events_members/1
  def show; end

  # GET /events_members/new
  def new
    @event_member = EventsMember.new
  end

  # GET /events_members/1/edit
  def edit; end

  # GET /events_members/check_in_code?event_id=1
  def check_in_code
    event = Event.find_by(id: params[:event_id])
    unless event.present?
      render json: { error: "Event not found." }, status: :not_found
      return
    end

    render json: {
      event_id: event.id,
      code: event.current_check_in_code,
      expires_in: event.check_in_expires_in_seconds
    }
  end

  #new code
  def remove_member_from_event
    @event = Event.find(params[:event_id])
    @member = Member.find(params[:member_id])

    if @event && @member && @event.members.include?(@member)
      # Remove the member from the event
      @event.members.delete(@member)

      points_to_remove = event_points_value(@event)
      @member.decrement!(:member_points, points_to_remove)

      flash[:notice] = "Member removed from event successfully. #{points_to_remove} points deducted."
    else
      flash[:alert] = "Failed to remove member from event!"
    end

    redirect_to events_members_path
  end

  # POST /events_members
  def create
    if admin_view_mode?
      @event_member = EventsMember.new(event_member_params)
    else
      current_member = Member.find_by(member_name: current_user&.full_name)
      unless current_member.present?
        redirect_to events_members_path, alert: "No member profile found for your account. Ask an admin to create one first."
        return
      end

      event_id = params.dig(:events_member, :event_id)
      unless event_id.present?
        redirect_to events_members_path, alert: "Select an event to check in."
        return
      end

      event = Event.find_by(id: event_id)
      unless event.present?
        redirect_to events_members_path, alert: "Event not found."
        return
      end

      submitted_code = params.dig(:events_member, :check_in_code)
      unless event.valid_check_in_code?(submitted_code)
        redirect_to events_members_path, alert: "Invalid or expired check-in code. Ask the event lead for the latest code."
        return
      end

      @event_member = EventsMember.new(event_id: event.id, member_id: current_member.id)
    end

    # Check if the member is already in the event
    if EventsMember.exists?(event_id: @event_member.event_id, member_id: @event_member.member_id)
      redirect_to events_members_path, alert: 'Member is already in the event!'
      return
    end

    respond_to do |format|
      if @event_member.save
        @member = Member.find(@event_member.member_id)
        @event = Event.find(@event_member.event_id)
        points_to_add = event_points_value(@event)
        @member.increment!(:member_points, points_to_add)

        format.html { redirect_to events_members_path, notice: "Member added to event successfully. #{points_to_add} points awarded." }
        format.json { render :show, status: :created, location: @event_member }
      else
        format.html { redirect_to events_members_path, alert: "Failed to add member to event! #{@event_member.errors.full_messages.join(', ')}" }
        format.json { render json: @event_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events_members/1
  def update
    respond_to do |format|
      if @event_member.update(event_member_params)
        format.html { redirect_to @event_member, notice: 'Event member was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events_members/1
  def destroy
    @event_member.destroy
    respond_to do |format|
      format.html { redirect_to events_members_url, notice: 'Event member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_member
    @event_member = EventsMember.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_member_params
    params.require(:events_member).permit(:event_id, :member_id)
  end

  def event_points_value(event)
    event&.event_points.to_i
  end
end
