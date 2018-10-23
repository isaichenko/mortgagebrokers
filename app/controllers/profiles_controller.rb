class ProfilesController < ApplicationController
  before_action :authenticate_user! , :load_profile
  def new
    @wizard = ModelWizard.new(Profile, session, params).start
    @profile = @wizard.object
  end
  def create
    @wizard = ModelWizard.new(Profile, session, params, profile_params).continue
    @profile = @wizard.object
    if @wizard.save
      @profile.license.attach(params[:profile][:license]) if params[:profile][:license]
      @profile.id_proof_1.attach(params[:profile][:id_proof_1]) if params[:profile][:id_proof_1]
      @profile.id_proof_2.attach(params[:profile][:id_proof_2]) if params[:profile][:id_proof_2]      
      package = Gateway::Package.new(@profile.package.stripe_package_id).get_package if params[:profile][:stripe_token]
      Gateway::Plan.new(current_user,params[:profile][:stripe_token]).add_new_card if package
      current_user.update_attributes(verification_status: BROKER_ON_HOLD)
      BrokerMailer.send_verification_process_notification(current_user).deliver_now
      redirect_to root_path, notice: "Your information for verification process has been submitted!. We will update you once on account verification."
    else
      render :new
    end
  end
  def show
    @profile = current_user.profile     
  end 
  private
  def load_profile
  	@languages = LanguageList::COMMON_LANGUAGES.map{|lang| lang.common_name}
    #@profile = Profile.find_by(id: params[:id])    
  end 
  def check_role
    if current_user
      current_user.role_id == 2 ? redirect_to(root_path) : redirect_to(request.referer)
    else
      redirect_to root_path, notice: "Please Login First"
    end
  end 
  def profile_params
    params[:profile][:areas] = eval(params[:profile][:areas]) if params[:profile][:areas]
    return params unless params[:profile]
    params.require(:profile).permit(:current_step,
      :title,
      :description,      
      :telephone_numbers,
      :company_address,
      :company,
      :license,
      :id_proof_1,
      :id_proof_2,
      :twitter_link,
      :youtube_link,
      :facebook_link,
      :user_id,
      :package_id,
      :stripe_token,
      :mortgage_types => [],
      :areas => [:place,:latitude,:longitude,:city,:state,:country],
      :languages => []    
    )
  end    	
end
