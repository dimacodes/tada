class SomethingController < ApplicationController

  get '/something' do
    if logged_in?
      @somethings = Something.where(:user_id => current_user.id)
      erb :'something/index'
    else
      redirect to '/login'
    end
  end

  # get '/something/new' do
  #   if logged_in?
  #     erb :'something/new'
  #   else
  #     redirect to '/login'
  #   end
  # end

  post '/something/new' do

    if params[:some_content] != "" || params[:some_title] != ""
      @nothing = Nothing.find(params[:nothing_id])
      @nothing.somethings << Something.create(params)
      @nothing.save
      redirect to "/nothing/#{@nothing.id}"
    end
  end

  get '/something/:id' do
    if logged_in?
      @something = Something.find_by(:id => params[:id])
      erb :'/something/show'
    else
      redirect to '/login'
    end
    #find_by
  end

  get '/something/:id/edit' do
    if logged_in?
      @something = Something.find(params[:id])
      erb :'/something/edit'
    else
      redirect to '/login'
    end
  end

  patch '/something/:id/edit' do
    # if params[:no_content] != "" || params[:no_title] != ""
    if params[:some_title] != ""
      @something = Something.find(params[:id])
      # @something.update(no_content: params[:no_content])
      @something.update(some_title: params[:some_title])
      @something.save
      redirect to "/something/#{@something.id}"
    end
  end

  delete '/something/:id/delete' do
    if logged_in?
      @something = Something.find(params[:id])
      @something.user_id == current_user.id
      @something.destroy
      redirect to "/nothing/#{@nothing.id}"
    end

    #find, destroy
  end

end

#form for editing something:
# <form method="get" action="/something/<%=@something.id%>/edit">
#
#     <input class='btn btn-primary' type='submit' value='Edit Something'>
# </form>
