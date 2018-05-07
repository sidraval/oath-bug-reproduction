class SecretsController < ApplicationController
  before_action :require_login

  def new
    render :new
  end

  def index
    render :index
  end
end
