class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
     @pet = Pet.create(params[:pets])
      if params["owner"]["name"].empty?
        @pet.owner = Pet.create(name: params["owner"]["name"])
        #Owner.find(params[:pets][:owner_id]).first
      end
     binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    ####### bug fix
    if !params[:pets].keys.include?("owner_id")
    params[:pets]["owner_id"] = []
    end
    #######
    
    @pet = Pet.find(params[:id])
    @pet.update(params["pets"])
    if !params["owner"]["name"].empty?
      @pet.owner = Pet.create(name: params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end