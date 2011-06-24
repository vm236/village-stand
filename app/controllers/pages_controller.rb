class PagesController < ApplicationController
  before_filter :assign_address
  before_filter :user_can_have_farm?, :only => :farmer
  def home
    @last_activities = LastActivity.last
    @farms = Farm.all
  end

  def marketplace
    if (params[:sort_by] == 'price')
      @farms = Farm.all.sort_by {|farm| sort_by_price(farm)}
      .paginate :page => params[:page], :per_page => 3
    elsif cookies[:latitude].nil? || cookies[:longitude].nil?
       @farms = Farm.all.sort_by{|farm| farm.distance_from(@address)}
      .paginate :page => params[:page], :per_page => 3
    else
      @farms = Farm.all.sort_by{|farm| farm.distance_from([Float(cookies[:latitude]),Float(cookies[:longitude])])}
      .paginate :page => params[:page], :per_page => 3
    end
  end


  def route
    @farm = Farm.find(params[:id])
  end

  def village_board
    @farm = Farm.find(params[:farm])
    @vote = Vote.new(params[:vote])
  end

  def farmer

  end

  def my_farm
    begin
      @farm = Farm.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, :notice => 'This is not your farm!'
      else
        raise PagesHelper::NotMyFarm unless current_user.farm.id.eql?(@farm.id)
      end
      rescue PagesHelper::NotMyFarm => e
        redirect_to root_path, :notice => e.message
  end

  def assign_address
     @address = get_user_address
  end


end

# TODO: Email sending
# DO: user form register modify - lat - long, asteriks for validation
# DO: HTML 5: geolocation
# TODO: Order checkout process 3rd party code(e-commerce)
# TODO: Favorite button, not bookmark
# TODO: Describe sellers interface