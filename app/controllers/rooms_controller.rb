class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def show
    @photos = @room.photos

    @booked = Reservation.where("room_id = ? AND user_id = ?", @room.id, current_user.id).present? if current_user
    @reviews = @room.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      if params[:images]
        params[:images].each do |img|
          @room.photos.create(image: img)
        end
      end
      @photos = @room.photos
      redirect_to rooms_path, notice: "Saved..."
    else
      flash[:alert] = "Please provide all information for this room."
      render :new
    end
  end

  def edit
    if current_user.id == @room.user.id
      @photos = @room.photos
    else
      redirect_to root_path, notice: "You do not have permission."
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        params[:images].each do |img|
          @room.photos.create(image: img)
        end
      end
      redirect_to rooms_path, notice: "Updated..."

    else
      flash[:alert] = "Please provide all information for this room."
      render :edit
    end
  end

  private
    def set_room
      def self.set_room
        @room
      end
      @room = Room.find(params[:id]).first
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, :image)
    end
end
