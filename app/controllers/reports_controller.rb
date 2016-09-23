class ReportsController < ApplicationController
  before_action :set_account

  def index
    @locations = @account.locations.count
    @archived_locations = Location.archived_locations_count(@account.id)
    @new_locations = Location.new_locations_count(@account.id)
    @top_states = fetch_states
    @top_sub_cat = {}
    @sub_cat_count = {}
    fetch_states.each do |state|
      @top_sub_cat[state[0][0].id] = fetch_categories(state[0][0].id)
      @sub_cat_count[state[0][0].id] = Location.where(account_id: @account.id, state_id: state[0][0].id).count
    end
  end

  private

  # Fetch top 3 states for locations of an account
  def fetch_states
    Account.top_3_locations(@account.id)
  end

  # For each state show top 2 sub categories
  def fetch_categories(state_id)
    Account.top_2_subcategories(@account.id, state_id)
  end

  def set_account
    @account = Account.where(id: params[:id]).first
  end
end
