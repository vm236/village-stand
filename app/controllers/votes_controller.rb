class VotesController < ApplicationController

  # GET /votes/new
  # GET /votes/new.xml
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # POST /votes
  # POST /votes.xml
  def create
    @vote = Vote.new(params[:vote])
    farm = params[:vote][:farm_id]
    uid = params[:vote][:user_id]
    @extant = Vote.find(:last, :conditions => ["farm_id = ? AND user_id = ?", farm, uid])
    last_vote_time = @extant.created_at unless @extant.blank?
    curr_time = Time.now

    if ((@extant && curr_time - last_vote_time >= 24.hours) || @extant.blank?)
      respond_to do |format|
        if @vote.save
          format.js { render :layout => false }
          format.html { redirect_to :back }
        else
          format.html { redirect_to :back }
          format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :js =>  "alert('You may vote once every 24 hours for any one item.');"
    end
  end
end