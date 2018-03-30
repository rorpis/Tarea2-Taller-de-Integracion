class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

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
  def new
    @submission = current_user.submissions.build
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = current_user.submissions.build(submission_params)

    respond_to do |format|
      if submission_params[:title].present? && submission_params[:body].present? && submission_params[:lead].present?
        if @submission.save
          format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
          format.json { render :show, status: :created, location: @submission }
        else
          format.html { render :new }
          format.json { render json: @submission.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_submission_path, notice: 'Debe llenar todos los campos para publicar una noticia.' }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
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
      params.require(:submission).permit(:title, :lead, :body)
    end
end
