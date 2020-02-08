class TweetsController < ApplicationController
    get '/tweets' do
        # binding.pry
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        # binding.pry 
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect to "/tweets/new"
        else
            @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(:user_id => params[:id])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find_by(:user_id => params[:id])
            if @tweet.user_id == session[:user_id]
                erb :'/tweets/edit'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content] == ""
            redirect to "/tweets/#{params[:id]}/edit"
        else
            @tweet.update(:content => params[:content])
            redirect to "/tweets/#{params[:id]}"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            if @tweet.user_id == session[:user_id]
                @tweet.destroy
                redirect to "/tweets"
            else
                redirect to "/tweets"
            end
        else
            redirect to '/login'
        end
    end
end
