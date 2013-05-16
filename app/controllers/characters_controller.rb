class CharactersController < ApplicationController
  def new
    @character = Character.new
  end
end
