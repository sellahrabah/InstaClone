class CommentsController < ApplicationController
  before_action :set_post, only: [ :create ] # Récupérer le post pour créer un commentaire
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user # Associer l'utilisateur connecté au commentaire

    respond_to do |format|
      if @comment.save
        # Envoi d'un e-mail au propriétaire du post
        UserMailer.notification_email(@post.user, "#{current_user.email} a commenté votre post !").deliver_now

        format.html { redirect_to @post, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to @post, alert: "There was an issue with your comment." } # Retour avec une alerte
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.post, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id]) # Trouve le post par son ID
    end

    def set_comment
      @comment = Comment.find(params[:id]) # Trouve le commentaire par son ID
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text) # Permet uniquement le texte du commentaire
    end
end
