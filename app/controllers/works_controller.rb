class WorksController < ApplicationController
  def index
    @works = Work.order(:id)
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "New work was successfully added."
      redirect_to home_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    work = Work.find(params[:id])
    work.update_attributes(work_params)
    work.save
    redirect_to work_path(work)
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to works_path
  end

  def home
    @works = Work.all_works
    @top_work = Work.top_work
    @top_movies = Work.top_works("movie")
    @top_books = Work.top_works("book")
    @top_albums = Work.top_works("album")
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
