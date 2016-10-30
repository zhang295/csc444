class PlayersController < ApplicationController
    before_action :authenticate_account!, except: [:show, :index]

    def create
        @player = Player.new
        @player.tournament_id = params[:tournament_id]
        @player.account_id = current_account.id
        @duplicate_player = Player.where(tournament_id: params[:tournament_id], account_id: current_account.id)
        if @duplicate_player.blank?
            if @player.save
                redirect_to tournaments_index_path, notice: 'Joined Tournament'
            else
                render 'new', notice: 'Invalid'
            end
        else
            redirect_to tournaments_index_path, notice: 'Already in Tournament'
        end
    end

    def show
        @player_info = Player.where(tournament_id: params[:tournament_id])
    end

    def update
        @player = Player.where(account_id: params[:account_id],tournament_id: params[:tournament_id])
        @player.update(group_id: params[:player][:group_id])
        redirect_to organizers_show_path
    end

end
