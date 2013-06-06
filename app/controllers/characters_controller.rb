class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def chose_role
    @character = Character.new
  end

  def new
    @character = Character.new(character_params)
    @character.role.career_skills.each do |skill|
      attributes = skill.attributes.slice *%w[name stat custom custom_description ip_multiplier special_ability]
      @character.skills.build(attributes.merge(type: "career"))
    end
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
