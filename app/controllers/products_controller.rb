class ProductsController < ApplicationController
  inherit_resources
  before_filter :admin_authorize
  layout  'admin'
end
