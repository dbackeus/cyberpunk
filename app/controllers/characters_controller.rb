class CharactersController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def index
    @user_characters = Character.where(creator: current_user)
    @campaign_characters = viewable_characters
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
      redirect_to character_path(@character), notice: "Character added! Please scroll down to add gear / cyberware etc..."
    else
      render :new
    end
  end

  def character_creation
  end

  def random_name
    name = Timeout.timeout(5) do
      HTTPI.get("http://donjon.bin.sh/name/rpc.cgi?type=Modern%20#{params[:sex] || "Male"}&n=1").body
    end
    render text: name
  end

  def edit
    @character = Character.editable_by(current_user).find(params[:id])
  end

  def update
    @character = Character.editable_by(current_user).find(params[:id])

    if @character.update_attributes(character_params)
      redirect_to character_path(@character), notice: "Character updated!"
    else
      render :edit
    end
  end

  def destroy
    character = current_user.characters.find(params[:id])
    character.destroy
    redirect_to characters_path, notice: "Character destroyed!"
  end

  private
  def character_params
    params.require(:character).permit!
  end

  def viewable_characters
    if current_membership.referee?
      current_campaign.characters
    else
      current_campaign.characters.select { |c| c.player_ids.any? }
    end
  end
end
