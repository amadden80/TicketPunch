class UsersController < ApplicationController

  before_filter :authenticate!, except: [:new, :create, :log_in]

  def new
    @user = User.new()
  end
  def create
    user = User.create(user_params)
    redirect_to user_path(user)
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    user.update( user_params )
    user.save!
    redirect_to user_path(user)
  end

  def profile
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.destroy(params[:id])
    redirect_to root_path
  end


  def log_in
  end

  def wish
    if movie = Movie.find(params[:movie_id])
      entry = WatchListEntry.create({
        user: current_user,
        movie: movie
      })
    end
    redirect_to '/profile'
  end

  def destroy_wish
    WatchListEntry.destroy(params[:id])
    redirect_to '/profile'
  end


  private


  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

end
