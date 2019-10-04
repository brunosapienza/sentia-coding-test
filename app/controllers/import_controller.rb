class ImportController < ApplicationController
  def index
    # HEADS UP!! this is bad performance, I would never perform a select all query and paginate on the fron-end.
    # In a real world scenario, I would paginate this with a gem like Kaminari and built a custom JS compoment with React&Bootstrap
    # to perform a search & sorting respecting the pagination.

    # That said, the challenge description mentions it can be done within 1 hour, for the sake of simplicty, and a feasible time to
    # wrap up the front-end requirements, I'm using bootstrap-table to add functionalities such sorting and search.
    # This library focus on simple html structure and it is not compatible with db pagination although, the CSV example
    # has only 19 rows hence, a "select all" here.
    @people = Person.all
  end

  def import
    uploader = Components::Uploader.new(params[:file])
    uploader.parse
    uploader.import!

    redirect_to root_url, notice: "Successfully Imported Data!"
  end
end
