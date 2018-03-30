class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  #
  # # GET /comments
  # # GET /comments.json
  def index
    @comments = Submission.find(params[:submission_id]).comments.order(created_at: :asc)
    #@comments = Comment.order(created_at: :desc)
    render :json => @comments.as_json, status: :ok
  end
  #
  # # GET /comments/1
  # # GET /comments/1.json
  def show
    @submission = Submission.find(params[:submission_id])
    @comment = Comment.find(params[:id])
    if @submission.id == @comment.submission_id
      render :json => @comment.as_json
    else
      render :json => {"error": "no calza id con noticia"}
    end
  end
  #
  # # GET /comments/new
  #def new
  #  @comment = Comment.new
  #end
  #
  # # GET /comments/1/edit
  # def edit
  # end

  # POST /comments
  # POST /comments.json
  def create
    @submission = Submission.find(params[:submission_id])
    @scomment = @submission.comments.build(comment_params)
    if @scomment.save
      render json: @scomment.as_json(except: [:updated_at]), status: :created
    else
      render json: @scomment.errors, status: :unprocessable_entity
    end
    #@comment.user = current_user

    #respond_to do |format|
    #  if comment_params[:title].present? && comment_params[:body].present?
    #    if @comment.save
    #      format.html { redirect_to @submission, notice: 'Comment was successfully created.' }
    #      #format.json { render :show, status: :created, location: @comment }
    #    else
    #      format.html { render :new }
    #      #format.json { render json: @comment.errors, status: :unprocessable_entity }
    #    end
    #  else
    #    format.html { redirect_to @submission, notice: 'Debe llenar los campos.' }
    #  end
    #end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
     #respond_to do |format|
       if @comment.update(comment_params)
         render json: @comment.as_json(except: [:updated_at]), status: :ok
       else
  #       format.html { render :edit }
         render json: @comment.errors, status: :unprocessable_entity
  #     end
     end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.destroy
      #format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      render json: {"ok": "ok"}, status: :ok
    else
      render json: {"error": "not found"}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      author = params["author"] if params["author"]
      comment = params["comment"] if params["comment"]
      #params["comment2"]["title"] = params["author"] if params["author"]
      #params["comment2"]["body"] = params["comment"] if params["comment"]
      params["comment"] = {"title": author, "body": comment}
      params.require(:comment).permit(:submission_id, :title, :body) #111

    end
end
