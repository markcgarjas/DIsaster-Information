class TypesController < ApplicationController
  before_action :set_params_type, only: [:edit, :update, :destroy]
  def index
    @types = Type.all
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(params_type)
    if @type.save
      flash[:notice] = "Type of Disaster was created successfully."
      redirect_to types_path
    else
      render :new
    end
  end

  def edit ;

  end

  def show

  end

  def update
    if @type.update(params_type)
      flash[:notice] = "Category was updated successfully."
      redirect_to types_path
    else
      render :edit
    end
  end

  def destroy
    @type.destroy
    flash[:notice] = "Category was deleted successfully."
    redirect_to types_path

  end


  private

  def params_type
    params.require(:type).permit(:name)
  end

  def set_params_type
    @type = Type.find(params[:id])
  end

end
