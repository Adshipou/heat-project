class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:check_member_attendance]

  def check_member_attendance
    def check_member_attendance
      if current_user.present?
        @member = Member.find_by(member_name: current_user.full_name)
        @attended = if @member.present? && (@member.meetings.any? || @member.events.any?)
          true
                    else
          false
                    end
      else
        @attended = false
      end
    end
  end

  def set_member
    @member = current_user.member
  end

  # GET /members or /members.json
  def index
    @members = Member.all
  end

  def require_login
    redirect_to login2_path unless session[:authenticated]
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to member_url(@member), notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html do
          # Add the following line to see the validation errors in the browser console
          puts @member.errors.inspect

          render :new, status: :unprocessable_entity
        end
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to member_url(@member), notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:member_name, :member_points, :executive_status)
    end
end
