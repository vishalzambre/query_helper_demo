class ApplicationController < ActionController::API
  include QueryHelper::QueryHelperConcern
  before_action :create_query_helper
end
