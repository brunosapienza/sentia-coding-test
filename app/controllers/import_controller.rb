class ImportController < ApplicationController
  def index
    @people = Person.page(params[:page])
  end

  def import
    uploader = Components::Uploader.new(params[:file])
    uploader.parse
    uploader.import!

    redirect_to root_url, notice: "Successfully Imported Data!"
  end
end
