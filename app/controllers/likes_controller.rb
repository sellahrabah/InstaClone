class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    if @like.save
      # Envoi d'un e-mail au propriétaire du post
      post_owner = @like.post.user
      if post_owner != current_user
        UserMailer.notification_email(post_owner, "#{current_user.email} a aimé votre post !").deliver_now
      end
      flash[:notice] = "You liked the post."
    else
      flash[:alert] = "You already liked this post."
    end

    redirect_to request.referer || root_path
  end


  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to request.referer || root_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
