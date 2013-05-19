class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      redirect_to characters_path, notice: "Character added!"
    else
      render :new
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])

    if @character.update_attributes(character_params)
      redirect_to character_path(@character), notice: "Character updated!"
    else
      render :edit
    end
  end

  def destroy
    character = Character.find(params[:id])
    character.destroy
    redirect_to characters_path, notice: "Character destroyed!"
  end

  private
  def character_params
    params.require(:character).permit!
  end
end
