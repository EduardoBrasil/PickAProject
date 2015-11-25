class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    begin
      logger.debug "Trying to get the Projects tables from the database"
      @projects = Project.all
      logger.info "Success getting all the projects from the database"
      logger.debug "Rendering the Projects index view"
    rescue ActiveRecord::RecordNotFound => e
      # If there are an error and the projects are unreachable,
      # Returns to home, and show an error message
      logger.error "Error getting the Projects table from database"
      logger.debug "Redirecting to the root path"
      format.html { redirect_to root_path, notice: 'Something comes wrong. Please, try again' }
    end
  end

  def show
    logger.debug "Trying to show a project with id: #{ @project. id }" 
  end

  def new
    begin
      logger.debug "Trying to construct a new Project object."
      @project = Project.new
      logger.info "Success constructing a new Project object."
    rescue e
      # If there are an error and there is no way to create a
      # project, returns to home and display an error message.
      logger.error e.to_s # Print the error in the log level.
      logger.error "Error cronstructing a new Project object."
      redirect_to root_path, notice: 'Something comes wrong. Please, try again'
    end
  end

  def edit
    logger.debug "Trying to edit a project with id: #{ @project. id }" 
  end

  def create
    # Create a new project with given params
    logger.debug "Trying to create a new project with given params"
    @project = Project.new(project_params)

    # [REMOVE] should be a association
    @project.author = "Test Author"
    @project.percentage = 0 # Project begin, 0% done.

    respond_to do |format|
      if @project.save
        # If it is ok, go to the project page and display a success message
        logger.info "Success creating and saving a new Project in the database, id: #{ @project.id }"
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the Project in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    logger.debug "Trying to update a project with id: #{ @project. id }" 
    respond_to do |format|
      if @project.update(project_params)
        # If it is ok, go to the project page and display a success message
        logger.info "Success saving modifications to Project, id: #{ project.id }"
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        # If something comes wrong, go to the form again
        logger.error "Error trying to save the modifyed Project in the database"
        logger.debug "Object's params:\n" + params.inspect # Returns a list of entered params
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.info "Destroying project, id: #{ @project.id }"
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :category, :level, :description, :status, :image_file,
      tasks_attributes: [:id, :title, :description, :difficult, :image_file, :_destroy])
    end

end
