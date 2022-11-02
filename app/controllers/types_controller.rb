class TypesController < ApplicationController

  def index
    @types = Type.all
  end

  private

  def params_category
    params.require(:category).permit(:name)
  end
end
