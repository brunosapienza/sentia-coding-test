class ImportController < ApplicationController
  def index
  end

  def import
    Components::Uploader.import(params[:file])
    redirect_to root_url, notice: "Successfully Imported Data!"
  end
end
