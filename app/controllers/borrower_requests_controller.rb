class BorrowerRequestsController < ApplicationController
  before_action :authenticate_user! , :check_role_access
  before_action :set_borrower_request, only: [:show, :edit, :update, :destroy]
  before_action :handle_expired_requests  

  # GET /borrower_requests
  # GET /borrower_requests.json
  def index    
    @borrower_requests = params[:filter] ? BorrowerRequest.where(status: params[:filter]).page(params[:page]) : BorrowerRequest.all.page(params[:page])
    @request_counts = BorrowerRequest.get_requests_count(current_user)
  end

  # GET /borrower_requests/1
  # GET /borrower_requests/1.json
  def show
    @borrower_bids = @borrower_request.bids
    @bids = @borrower_bids.order('rate asc')
    @last_bid = @borrower_bids.order('created_at desc').first.created_at if !@borrower_bids.blank?
  end

  # GET /borrower_requests/new
  def new
    @borrower_request = BorrowerRequest.new
  end

  # GET /borrower_requests/1/edit
  def edit
  end

  # POST /borrower_requests
  # POST /borrower_requests.json
  def create
    @borrower_request = BorrowerRequest.new(borrower_request_params)

    respond_to do |format|
      if @borrower_request.save
        @borrower_request.update_attributes(place: JSON.parse(params[:borrower_request][:place]))
        format.html { redirect_to borrower_requests_url, notice: 'Borrower request was successfully created.' }
        format.json { render :show, status: :created, location: @borrower_request }
      else
        format.html { render :new }
        format.json { render json: @borrower_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrower_requests/1
  # PATCH/PUT /borrower_requests/1.json
  def update
    respond_to do |format|
      if @borrower_request.update(borrower_request_params)
        @borrower_request.update_attributes(place: JSON.parse(params[:borrower_request][:place].gsub('=>', ':')))
        format.html { redirect_to @borrower_request, notice: 'Borrower request was successfully updated.' }
        format.json { render :show, status: :ok, location: @borrower_request }
      else
        format.html { render :edit }
        format.json { render json: @borrower_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrower_requests/1
  # DELETE /borrower_requests/1.json
  def destroy
    @borrower_request.destroy
    respond_to do |format|
      format.html { redirect_to borrower_requests_url, notice: 'Borrower request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish_request
    @borrower_request = BorrowerRequest.find(params[:id])
    if @borrower_request and @borrower_request.status == REQ_STATUS[:draft]
      BorrowerRequest.publish_borrower_request @borrower_request  
      redirect_to borrower_requests_url, notice: 'Your Request was successfully published.'
    else
      redirect_to borrower_requests_url, notice: 'Your Request was already published.'
    end 
  end 

  def cancel_request
    @borrower_request = BorrowerRequest.find(params[:id])
    if @borrower_request and @borrower_request.status == REQ_STATUS[:publish]
      BorrowerRequest.cancel_borrower_request @borrower_request  
      redirect_to borrower_requests_url, notice: 'Your Request was successfully cancelled.'
    else
      redirect_to borrower_requests_url, notice: 'Please try again'
    end 
  end 

  def accept_broker
    @proposal = Bid.find(params[:id])        
    Bid.accept_proposal_and_reject_other_bids(@proposal)
    redirect_to contact_broker_borrower_request_url
  end 

  def contact_broker 
    @bid = Bid.find(params[:id])
  end     

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrower_request
      @borrower_request = BorrowerRequest.find(params[:id])
    end

    def check_role_access
      if current_user.role.name == BORROWER 
        return true
      else
        redirect_to root_path, alert: 'Your dont have access to this'
      end 
    end 
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def borrower_request_params
      params.require(:borrower_request).permit(:mortgage_type,
        :property_address,
        :property_value,
        :credit_score,
        :mortagage_level,
        :description,
        :user_id,
        :latitude,
        :longitude,
        :status,
        :bidding_end_time,
        :place => [:city,:state,:country])
    end
end
