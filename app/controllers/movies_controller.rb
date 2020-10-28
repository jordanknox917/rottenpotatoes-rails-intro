class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    #what do you mean this isnt very efficient? lol
    if params[:ratings] == nil and session[:ratings] == nil
      params[:ratings] = {"G" => 1,"PG" => 1,"PG-13" => 1,"R" => 1}
    elsif params[:ratings] == nil and session[:ratings] != nil
      params[:ratings] = session[:ratings]
    end
    if params[:sort] == nil and session[:sort] == nil
      params[:sort] = nil
    elsif params[:sort] == nil and session[:sort] != nil
      params[:sort] = session[:sort]
    end
    ratings = params[:ratings].keys
    @ratings_to_show = ratings
    @movies = Movie.with_ratings(ratings) 
    if params[:sort] == 'title'
      @highlight_title = 'bg-warning hilite'
      @movies = @movies.order(:title)
    elsif params[:sort] == 'date'
      @highlight_date = 'bg-warning hilite'
      @movies = @movies.order(:release_date)
    end
#     session[:ratings] = params[:ratings]
#     session[:sort] = params[:sort]
    #call redirect_to
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:ratings] = params[:ratings]
      session[:sort] = params[:sort]
      redirect_to movies_path([session[:sort], session[:ratings]]) and return
    end
#     redirect_to movies_path([session[:sort], session[:ratings]]) and return
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
