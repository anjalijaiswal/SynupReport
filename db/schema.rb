# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160922111020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "uuid-ossp"

  create_table "Livelink", force: :cascade do |t|
    t.string   "livelink",    limit: 255
    t.integer  "site_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "Livelink", ["location_id"], name: "index_Livelink_on_location_id", using: :btree
  add_index "Livelink", ["site_id"], name: "index_Livelink_on_site_id", using: :btree

  create_table "account_abilities", force: :cascade do |t|
    t.integer  "account_id"
    t.json     "abilities"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_sites", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "cname",                     limit: 255,                 null: false
    t.string   "stripe_cust",               limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                              default: false
    t.integer  "plan_id"
    t.integer  "downgrade_count"
    t.boolean  "can_edit_location_sites",               default: false
    t.string   "company_logo_file_name",    limit: 255
    t.string   "company_logo_content_type", limit: 255
    t.integer  "company_logo_file_size"
    t.datetime "company_logo_updated_at"
    t.string   "company_name",              limit: 255
    t.string   "stripe_customer_id",        limit: 255
    t.integer  "credits",                               default: 0
    t.boolean  "hide_duplicates",                       default: false
    t.boolean  "can_skip_address",                      default: false
    t.integer  "user_type",                             default: 0
    t.json     "abilities"
    t.boolean  "blocked",                               default: false
  end

  add_index "accounts", ["cname"], name: "index_accounts_on_cname", unique: true, using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "accounts_discounts", force: :cascade do |t|
    t.integer  "discount_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts_plans", id: false, force: :cascade do |t|
    t.integer  "account_id", null: false
    t.integer  "plan_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts_plans", ["account_id", "plan_id"], name: "index_accounts_plans_on_account_id_and_plan_id", using: :btree
  add_index "accounts_plans", ["plan_id", "account_id"], name: "index_accounts_plans_on_plan_id_and_account_id", using: :btree

  create_table "agency_email_settings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "from_email",    limit: 255
    t.string   "from_name",     limit: 255
    t.boolean  "confirmed"
    t.string   "dkim_host",     limit: 255
    t.string   "dkim_value",    limit: 255
    t.string   "spf_host",      limit: 255
    t.string   "spf_value",     limit: 255
    t.boolean  "dkim_verified"
    t.boolean  "spf_verified"
    t.string   "postmark_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "schedule"
  end

  create_table "agency_settings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name",                       limit: 255
    t.string   "street",                     limit: 255
    t.string   "city",                       limit: 255
    t.string   "state",                      limit: 255
    t.string   "zip",                        limit: 255
    t.string   "phone",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_logo_file_name",    limit: 255
    t.string   "business_logo_content_type", limit: 255
    t.integer  "business_logo_file_size"
    t.datetime "business_logo_updated_at"
  end

  create_table "agency_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "data"
  end

  create_table "api_requests", force: :cascade do |t|
    t.text     "request_type"
    t.json     "context"
    t.json     "request"
    t.text     "response"
    t.datetime "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authority_statuses", force: :cascade do |t|
    t.string   "keyword",    limit: 255
    t.string   "engine",     limit: 255
    t.string   "locale",     limit: 255
    t.integer  "keyword_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
    t.datetime "sent_time"
    t.datetime "recd_time"
    t.string   "s3_key",     limit: 1024
  end

  create_table "black_listed_listings", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "postal_code",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number", limit: 255
  end

  add_index "black_listed_listings", ["location_id"], name: "index_black_listed_listings_on_location_id", using: :btree

  create_table "bulk_sheet_data", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "listing_id"
    t.date     "date"
    t.string   "action",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_item_id"
  end

  add_index "bulk_sheet_data", ["listing_id"], name: "index_bulk_sheet_data_on_listing_id", using: :btree
  add_index "bulk_sheet_data", ["order_item_id"], name: "index_bulk_sheet_data_on_order_item_id", unique: true, using: :btree
  add_index "bulk_sheet_data", ["site_id"], name: "index_bulk_sheet_data_on_site_id", using: :btree

  create_table "bulk_sheets", force: :cascade do |t|
    t.integer  "site_id"
    t.date     "date"
    t.string   "csv_file_name",    limit: 255
    t.string   "csv_content_type", limit: 255
    t.integer  "csv_file_size"
    t.datetime "csv_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cancelled_listings", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "location_id"
    t.text     "live_link"
    t.string   "status",      limit: 255
    t.json     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "response"
  end

  add_index "cancelled_listings", ["location_id"], name: "index_cancelled_listings_on_location_id", using: :btree
  add_index "cancelled_listings", ["site_id"], name: "index_cancelled_listings_on_site_id", using: :btree

  create_table "card_settlements", force: :cascade do |t|
    t.integer  "account_id"
    t.decimal  "amount"
    t.text     "description"
    t.string   "stripe_charge_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "retries",                      default: 0
    t.string   "status",           limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "archived",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "category_mappings", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "site_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.datetime "posting_date"
    t.string   "type",              limit: 255
    t.string   "description",       limit: 1024
    t.decimal  "amount"
    t.integer  "account_id"
    t.integer  "order_id"
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                       default: false, null: false
    t.integer  "no_of_days"
    t.integer  "bill_id"
    t.string   "stripe_invoice_id", limit: 255
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "state",      limit: 255
    t.string   "hierarchy",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_mappings", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "site_city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "claim_logs", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "site_id"
    t.string   "site_url",          limit: 255
    t.text     "stack_trace"
    t.string   "remarks",           limit: 255
    t.string   "status",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page_file_name",    limit: 255
    t.string   "page_content_type", limit: 255
    t.integer  "page_file_size"
    t.datetime "page_updated_at"
    t.boolean  "already_claimed"
  end

  create_table "components", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.string   "grouping",       limit: 255
    t.integer  "level"
    t.decimal  "monthly_fee"
    t.string   "frequency",      limit: 255
    t.integer  "max_count"
    t.decimal  "fixing_fee"
    t.decimal  "coupon_amount"
    t.boolean  "archived",                   default: false, null: false
    t.integer  "plan_id"
    t.decimal  "listing_coupon"
    t.string   "stripe_plan_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "components", ["grouping", "level", "plan_id"], name: "index_components_on_grouping_and_level_and_plan_id", unique: true, using: :btree

  create_table "connected_accounts", force: :cascade do |t|
    t.integer  "account_id"
    t.text     "type"
    t.text     "provider_id"
    t.json     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "credentials_valid", default: true
  end

  create_table "connected_accounts_locations", force: :cascade do |t|
    t.integer  "connected_account_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "iso",        limit: 255
    t.boolean  "archived",               default: false
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["iso"], name: "index_countries_on_iso", unique: true, using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "description",      limit: 255
    t.decimal  "original_amount"
    t.decimal  "remaining_amount"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                     default: false, null: false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "subscription_id"
    t.integer  "location_id"
    t.string   "type",             limit: 255
    t.integer  "refund_id"
    t.integer  "listing_id"
  end

  create_table "crawl_engines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crawl_engines_plan_sites", force: :cascade do |t|
    t.integer  "crawl_engine_id"
    t.integer  "plan_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crawl_engines_sites", force: :cascade do |t|
    t.integer  "crawl_engine_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crawler_item_statuses", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "site_id"
    t.text     "site_url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "crawler_status",       limit: 255
    t.string   "scraper_status",       limit: 255
    t.integer  "crawl_statuses_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",               limit: 255
    t.float    "time_taken"
    t.integer  "live_link_count",                  default: 0
    t.integer  "live_link_completed",              default: 0
    t.string   "request_id",           limit: 255
    t.integer  "gcse_live_link_count",             default: 0
    t.boolean  "crawl_completed",                  default: false
    t.boolean  "gcse_crawl_completed",             default: false
  end

  add_index "crawler_item_statuses", ["crawl_statuses_id"], name: "index_crawler_item_statuses_on_crawl_statuses_id", using: :btree

  create_table "crawler_statuses", force: :cascade do |t|
    t.string   "crawl_type",    limit: 255
    t.string   "search_engine", limit: 255
    t.boolean  "crawling",                  default: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "location_id"
    t.string   "request_id",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crawler_statuses", ["location_id", "crawl_type", "search_engine"], name: "index_crawler_statuses_on_loc_crawl_engine", unique: true, using: :btree
  add_index "crawler_statuses", ["location_id"], name: "index_crawler_statuses_on_location_id", using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "stripe_card", limit: 255
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                default: false
  end

  add_index "credit_cards", ["account_id"], name: "index_credit_cards_on_account_id", using: :btree
  add_index "credit_cards", ["stripe_card"], name: "index_credit_cards_on_stripe_card", unique: true, using: :btree

  create_table "current_data_views", force: :cascade do |t|
    t.integer  "listing_item_id"
    t.integer  "name"
    t.integer  "title"
    t.integer  "source_ref"
    t.integer  "site_url"
    t.integer  "live_link"
    t.integer  "biz_url"
    t.integer  "street"
    t.integer  "city"
    t.integer  "state"
    t.integer  "postal_code"
    t.integer  "country_code"
    t.integer  "phone"
    t.integer  "latitude"
    t.integer  "longitude"
    t.integer  "full_address"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "loc_id"
  end

  add_index "current_data_views", ["loc_id"], name: "index_current_data_views_on_loc_id", using: :btree
  add_index "current_data_views", ["site_id"], name: "index_current_data_views_on_site_id", using: :btree

  create_table "current_review_data", force: :cascade do |t|
    t.integer  "listing_item_id"
    t.integer  "site_id"
    t.integer  "location_id"
    t.integer  "title"
    t.integer  "content"
    t.integer  "author_name"
    t.integer  "author_avatar"
    t.integer  "author_url"
    t.integer  "rating"
    t.integer  "date"
    t.integer  "date_string"
    t.integer  "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dashboard_agency_configs", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "business_logo_file_name",    limit: 255
    t.string   "business_logo_content_type", limit: 255
    t.integer  "business_logo_file_size"
    t.datetime "business_logo_updated_at"
    t.string   "custom_domain",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                      limit: 255
  end

  create_table "discounts", force: :cascade do |t|
    t.integer  "component_id"
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.decimal  "discount_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                    default: false, null: false
  end

  create_table "duplicate_listing_items", force: :cascade do |t|
    t.integer  "listing_item_id"
    t.boolean  "processed",           default: false
    t.boolean  "removed_from_search", default: false
    t.boolean  "removed_completely",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.datetime "created_date"
  end

  add_index "duplicate_listing_items", ["listing_item_id"], name: "index_duplicate_listing_items_on_listing_item_id", using: :btree
  add_index "duplicate_listing_items", ["site_id"], name: "index_duplicate_listing_items_on_site_id", using: :btree

  create_table "email_templates", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "account_id"
    t.uuid     "email_type_id"
    t.string   "name",          limit: 255
    t.string   "subject",       limit: 255
    t.text     "body"
    t.string   "postmark_tag",  limit: 255
    t.text     "merge_tags",                default: [],    array: true
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "attachment",                default: false
  end

  create_table "email_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "data"
  end

  create_table "error_logs", force: :cascade do |t|
    t.string   "location_id",   limit: 255
    t.string   "site_id",       limit: 255
    t.string   "site_url",      limit: 255
    t.string   "error_type",    limit: 255
    t.text     "stack_trace"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "error_message", limit: 255
    t.string   "priority",      limit: 255
    t.string   "component",     limit: 255
    t.boolean  "fixed",                     default: false
  end

  add_index "error_logs", ["component"], name: "index_error_logs_on_component", using: :btree
  add_index "error_logs", ["error_message"], name: "index_error_logs_on_error_message", using: :btree
  add_index "error_logs", ["location_id"], name: "index_error_logs_on_location_id", using: :btree
  add_index "error_logs", ["site_url"], name: "index_error_logs_on_site_url", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.boolean  "archived",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features", ["key"], name: "index_features_on_key", unique: true, using: :btree

  create_table "features_sites", force: :cascade do |t|
    t.integer  "feature_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features_sites", ["feature_id"], name: "index_features_sites_on_feature_id", using: :btree
  add_index "features_sites", ["site_id"], name: "index_features_sites_on_site_id", using: :btree

  create_table "job_runs", force: :cascade do |t|
    t.integer  "job_id"
    t.date     "run_date"
    t.string   "status",      limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "archived",                default: false, null: false
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: :cascade do |t|
    t.date     "start_date"
    t.string   "frequency",       limit: 255
    t.boolean  "archived",                    default: false, null: false
    t.integer  "subscription_id"
    t.date     "end_date"
    t.string   "type",            limit: 255
    t.string   "name",            limit: 255
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "keyword",     limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.boolean  "primary"
    t.integer  "location_id"
    t.boolean  "archived",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keywords", ["location_id"], name: "index_keywords_on_location_id", using: :btree

  create_table "listing_histories", force: :cascade do |t|
    t.integer  "total_count"
    t.integer  "present_count"
    t.integer  "not_present_count"
    t.integer  "valid_count"
    t.integer  "invalid_count"
    t.integer  "duplicate_count"
    t.integer  "location_id",                       null: false
    t.boolean  "archived",          default: false, null: false
    t.integer  "fixed_count",       default: 0
    t.decimal  "listing_score"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listing_histories", ["location_id"], name: "index_listing_histories_on_location_id", using: :btree

  create_table "listing_item_features", force: :cascade do |t|
    t.string   "value",           limit: 1024
    t.integer  "listing_item_id"
    t.integer  "feature_id"
    t.boolean  "archived",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listing_item_features", ["feature_id"], name: "index_listing_item_features_on_feature_id", using: :btree
  add_index "listing_item_features", ["listing_item_id"], name: "index_listing_item_features_on_listing_item_id", using: :btree

  create_table "listing_items", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "title",                   limit: 255
    t.string   "source",                  limit: 255
    t.string   "source_ref",              limit: 1024
    t.string   "site_url",                limit: 1024
    t.string   "live_link",               limit: 1024
    t.string   "biz_url",                 limit: 1024
    t.boolean  "primary"
    t.boolean  "claimed"
    t.string   "street",                  limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "postal_code",             limit: 255
    t.string   "country_code",            limit: 255
    t.string   "phone",                   limit: 255
    t.string   "latitude",                limit: 255
    t.string   "longitude",               limit: 255
    t.string   "full_address",            limit: 255
    t.string   "rating",                  limit: 255
    t.string   "rating_count",            limit: 255
    t.string   "category",                limit: 255
    t.integer  "primary_score"
    t.integer  "secondary_score"
    t.boolean  "name_present"
    t.boolean  "phone_present"
    t.boolean  "address_present"
    t.boolean  "biz_url_present"
    t.boolean  "category_present"
    t.boolean  "name_valid"
    t.boolean  "address_valid"
    t.boolean  "phone_valid"
    t.boolean  "biz_url_valid"
    t.boolean  "category_valid"
    t.boolean  "menu_present"
    t.boolean  "media_present"
    t.boolean  "coupons_present"
    t.boolean  "description_present"
    t.boolean  "payment_method_present"
    t.boolean  "operating_hours_present"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                             default: false, null: false
    t.boolean  "not_a_duplicate",                      default: false
    t.string   "scrape_status",           limit: 255
    t.string   "scrape_message",          limit: 255
    t.integer  "scrape_retries",                       default: 0
    t.integer  "review_count",                         default: 0
    t.string   "review_status",           limit: 255
    t.string   "review_message",          limit: 255
    t.integer  "review_retries",                       default: 0
    t.boolean  "flagged_as_dup"
    t.integer  "recent_review_id",                     default: 0
    t.boolean  "submitted",                            default: false
    t.string   "external_id",             limit: 255
  end

  add_index "listing_items", ["listing_id"], name: "index_listing_items_on_listing_id", using: :btree
  add_index "listing_items", ["recent_review_id"], name: "index_listing_items_on_recent_review_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "site_user_name",          limit: 255
    t.string   "site_passwd",             limit: 255
    t.integer  "site_id"
    t.integer  "location_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                             default: false, null: false
    t.string   "live_link",               limit: 1024
    t.string   "crawl_status",            limit: 255
    t.string   "crawl_message",           limit: 255
    t.integer  "crawl_retries",                        default: 0
    t.string   "listing_site_id",         limit: 255
    t.string   "additional_info",         limit: 2048
    t.boolean  "owned",                                default: false
    t.string   "claim_state",             limit: 255
    t.string   "verification_code",       limit: 255
    t.boolean  "is_updated_by_user",                   default: false
    t.datetime "live_link_updated_at"
    t.string   "live_link_updated_by",    limit: 255
    t.datetime "claim_initiate_time"
    t.string   "claim_message",           limit: 1024
    t.integer  "claim_status"
    t.datetime "claimed_at"
    t.boolean  "pin_requested"
    t.boolean  "manager_invited"
    t.integer  "primary_listing_item_id"
    t.integer  "active_order_item_id"
    t.boolean  "wrong_credentials"
    t.json     "data"
    t.integer  "claim_log_id"
  end

  add_index "listings", ["location_id", "site_id"], name: "index_listings_on_location_id_and_site_id", unique: true, using: :btree
  add_index "listings", ["location_id"], name: "index_listings_on_location_id", using: :btree
  add_index "listings", ["primary_listing_item_id"], name: "index_listings_on_primary_listing_item_id", using: :btree
  add_index "listings", ["site_id"], name: "index_listings_on_site_id", using: :btree

  create_table "location_biz_hours", force: :cascade do |t|
    t.string   "day",         limit: 255
    t.string   "start_time",  limit: 255
    t.string   "end_time",    limit: 255
    t.integer  "location_id"
    t.boolean  "archived",                default: false, null: false
    t.boolean  "holiday",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "location_biz_hours", ["location_id"], name: "index_location_biz_hours_on_location_id", using: :btree

  create_table "location_email_settings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "location_id"
    t.json     "enabled"
    t.text     "to_emails",   default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "data"
  end

