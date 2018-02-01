class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content]==""
        redirect to "/tweets/new"
      else
        @tweet=Tweet.new(content: params["content"])
        @tweet.user_id=current_user.id
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
      if logged_in?
        @tweet=Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do
        if logged_in?
          @tweet=Tweet.find_by_id(params[:id])
          erb :'tweets/edit_tweet'
        else
          redirect to '/login'
        end
      end

      patch '/tweets/:id' do
          if logged_in?
            @tweet=Tweet.find_by_id(params[:id])
            if @tweet.user_id==current_user.id
              @tweet.content=params[:content]
              @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/#{@tweet.id}"
          else
            redirect to '/login'
          end
        end

    delete '/tweets/:id/delete' do
        if logged_in?
          @tweet=Tweet.find_by_id(params[:id])
          @tweet.delete
            redirect to "/tweets"
        else
          redirect to '/login'
        end
      end


  end
