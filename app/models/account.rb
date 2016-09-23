class Account < ActiveRecord::Base
  has_many :locations

  def self.top_3_locations(account_id)
    states_id = Location.where(account_id: account_id)
                        .select('state_id')
                        .group('state_id')
                        .count
                        .sort_by { |state_id, count| count }
                        .last(3)
    states_id.each { |id| id[0] = State.where(id: id[0]) }
  end

  def self.top_2_subcategories(account_id, state_id)
    sub_categories_id = Location.where(account_id: account_id, state_id: state_id)
                                .select('sub_category_id')
                                .group('sub_category_id')
                                .count
                                .sort_by { |sub_category_id, count| count }
                                .last(2)
    sub_categories = sub_categories_id.each { |id| id[0] = SubCategory.where(id: id[0]) }
  end
end
