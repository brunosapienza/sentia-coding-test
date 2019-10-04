class ImportController < ApplicationController
  def index
    # HEADS UP!! this is bad performance, I would never perform a select all query and paginate on the fron-end.
    # In a real world scenario, I would paginate this with a gem like Kaminari. For the sake of simplicty, and a feasible time to
    # wrap up the front-end requirements, I'm using bootstrap-table to add functionalities such sorting and search and it's not
    # compatible with db pagination. 
    @people = Person.all
  end

  def import
    uploader = Components::Uploader.new(params[:file])
    uploader.parse
    uploader.import!

    redirect_to root_url, notice: "Successfully Imported Data!"
  end
end
