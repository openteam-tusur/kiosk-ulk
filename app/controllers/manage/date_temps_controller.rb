class Manage::DateTempsController < Manage::ApplicationController
  before_action :find_item, only: [:edit, :show, :update]

  def index
    @date_temps = DateTemp.ordered.page(params[:page]).per(50)
  end

  def new
    @date_temp = DateTemp.new
    Place.ordered.each do |place|
      temp = Temp.new(place: place)
      @date_temp.temps << temp
    end
  end

  def create
    @date_temp = DateTemp.new(date_temp_params) #raise params.inspect
    if @date_temp.save
      redirect_to manage_date_temp_path(@date_temp)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @date_temp.update(date_temp_params)
      redirect_to manage_date_temp_path(@date_temp), notice: "Данные были успешно обновлены!"
    else
      render "edit"
    end
  end

  def destroy
    @date_temp.destroy
    redirect_to manage_date_temps_path, notice: "Дата удалена!"
  end

  private

  def find_item
    @date_temp = DateTemp.find(params[:id])
  end

  def date_temp_params
    params.require(:date_temp).permit(:date_title, temps_attributes: [:id, :place_id, :temperature])
  end
end
