class Location < ActiveRecord::Base
  belongs_to :account
  belongs_to :state
  belongs_to :sub_category

  scope :created_this_month, (lambda do
    where(
      'locations.created_at > ? AND locations.created_at < ?',
      Time.now.beginning_of_month, Time.now.end_of_month
    )
  end)

  scope :updated_this_month, (lambda do
    where(
      'locations.updated_at > ? AND locations.updated_at < ?',
      Time.now.beginning_of_month, Time.now.end_of_month
    )
  end)

  def self.archived_locations_count(account_id)
    updated_this_month.where('archived = ? and account_id = ?', true, account_id).count
  end

  def self.new_locations_count(account_id)
    created_this_month.where('archived = ? and account_id = ?', false, account_id).count
  end
end
