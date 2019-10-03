class ImportController < ApplicationController
  def index
  end

  def import
    data = Components::Uploader.new(params[:file]).parse
    #data.import!

    redirect_to root_url, notice: "Successfully Imported Data!"
  end
end
