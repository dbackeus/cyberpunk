class CharactersController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def index
    @user_characters = Character.where(creator: current_user)
    @campaign_characters = current_campaign.characters
  end

  def show
    @character = Character.find(params[:id])
  end

  def chose_role
    @character = Character.new
  end

  def new
    @character = Character.new(character_params.merge(creator: current_user))
    @character.role.career_skills.each do |skill|
      @character.skills.build(type: "career", skill: skill)
    end
  end

  def create
    @character = Character.new(character_params.merge(creator: current_user))

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

  def character_creation
  end

  def random_name
    name = Timeout.timeout(5) do
      HTTPI.get("http://donjon.bin.sh/name/rpc.cgi?type=Modern%20#{params[:sex] || "Male"}&n=1").body
    end
    render text: name
  end

  private
  def character_params
    params.require(:character).permit!
  end
end
