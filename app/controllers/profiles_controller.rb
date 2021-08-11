class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    # for use with simpleform nested fields for address in new profile form. 
    @profile.build_address
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)
    # gets current user id for use in profile form hidden field. 
    @profile.user_id = current_user.id

    respond_to do |format|
      if @profile.save
        # redirects to rootpath after creating a profile and address
        format.html { redirect_to root_path, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # address parameters are passed as address_attributes: [] with all the relevant values inside the array
    def profile_params
      params.require(:profile).permit(:user_name, :first_name, :last_name, :bio, :user_id, :profile_img, address_attributes: [:house_number, :street_name, :suburb, :postcode, :state, :country])
    end
end
