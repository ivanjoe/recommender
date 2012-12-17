require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { action: @movie.action, adventure: @movie.adventure, animation: @movie.animation, children: @movie.children, comedy: @movie.comedy, crime: @movie.crime, documentary: @movie.documentary, drama: @movie.drama, fantasy: @movie.fantasy, film_noir: @movie.film_noir, horror: @movie.horror, imdb_url: @movie.imdb_url, movie_title: @movie.movie_title, musical: @movie.musical, mystery: @movie.mystery, release_date: @movie.release_date, romance: @movie.romance, sci_fi: @movie.sci_fi, thriller: @movie.thriller, unknown: @movie.unknown, video_release_date: @movie.video_release_date, war: @movie.war, western: @movie.western }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    put :update, id: @movie, movie: { action: @movie.action, adventure: @movie.adventure, animation: @movie.animation, children: @movie.children, comedy: @movie.comedy, crime: @movie.crime, documentary: @movie.documentary, drama: @movie.drama, fantasy: @movie.fantasy, film_noir: @movie.film_noir, horror: @movie.horror, imdb_url: @movie.imdb_url, movie_title: @movie.movie_title, musical: @movie.musical, mystery: @movie.mystery, release_date: @movie.release_date, romance: @movie.romance, sci_fi: @movie.sci_fi, thriller: @movie.thriller, unknown: @movie.unknown, video_release_date: @movie.video_release_date, war: @movie.war, western: @movie.western }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
