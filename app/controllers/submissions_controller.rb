class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  #def list
  #  @submissions = Submission.order(created_at: :desc)
  #end

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.order(created_at: :desc)
    #json_response(@submissions)
    render :json => @submissions.as_json
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])
    render :json => @submission.as_json
  end

  # GET /submissions/new
  #def new
  #  @submission = Submission.create!(todo_params)
  #  json_response(@submission, :created)
  #end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    #@submission = current_user.submissions.build(submission_params)
    @submission = Submission.new(submission_params)
    if @submission.save
      json_response(@submission, :created)
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
      if @submission.update(submission_params)
        render json: @submission, status: :ok
      else
        render json: @submission.errors, status: :unprocessable_entity
      end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    if @submission.destroy
      render json: {"ok": "ok"}, status: :ok
    else
      render json: {"error": "not found"}, status: :unprocessable_entity
    end
  end

  def upvote
    @submission = Submission.find(params[:id])
    @submission.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @submission = Submission.find(params[:id])
    @submission.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params["submission"]["lead"] = params["subtitle"] if params["subtitle"]
      params.require(:submission).permit(:title, :lead, :body)
    end
end
