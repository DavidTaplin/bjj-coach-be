class MovesController < ApplicationController
    before_action :set_move, only: [:show, :update, :destroy]

    def index 
        moves = Move.all
        render json: moves 
    end

    def show
        render json: @move 
    end

    def create 
        move = Move.new(move_params)
        if move.save
            render json: { move: move, message: "New Move Created Successfully" }, status: :created
        else
            render json: { error: move.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @move.update(move_params)
            render json: { move: @move, message:"Move Has Been Succesfully Updated" }
        else
            render json: { error: @move.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
       if @move.destroy
        render json: { message: "Move was successfully deleted"}, status: 200
        else 
        render json: { error: @move.errors.full_messages }, status: :unprocessable_entity
      end

    private

    def set_move
        @move = Move.find(params[:id])
    end

    def move_params
        params.require(:move).permit(:name, :position, :grip)
    end
end

