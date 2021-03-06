class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID

    # will render app/views/movies/show.<extension> by default
  end

  def index

      @sort=params['sort']
      @all_ratings = Movie.Rate
       @selected = params['ratings']
    @movies = Movie.all
    #@movies = Movies.scoped
    @movies = Movie.find(:all, :order=>"title ASC")  if @sort == 'title'
     @movies = Movie.find(:all, :order=>"release_date ASC")  if @sort == 'release_date'
      @movies = Movie.find(:all,:conditions=>["rating == ? ", @selected.keys]) if @selected != nil
      session[:sort] = @sort
      session[:selected] = @selected
        
   end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    session[:movie] = @movie
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    session[:movie] = @movie
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


end
