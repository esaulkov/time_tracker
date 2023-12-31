# frozen_string_literal: true

class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.invite!(user_params, current_user)

    if @user.errors.empty?
      flash[:notice] = "Invitation sent successfully."
      redirect_to admin_invitations_path
    else
      flash.now[:alert] = "Error sending invitation. Please check the form for errors."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
