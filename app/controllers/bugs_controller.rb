class BugsController < ApplicationController
    # load_and_authorize_resource

    before_action :find_bug, only: [:show, :edit, :update, :destroy]
    before_action :find_project, only: [:edit, :new, :show, :index, :create]

    # before_action :validate_user, only: [:create, :update, :destroy]
    # before_action :remember_page, only: [:new, :index]

    def new
        @bug = @project.bugs.build()
        @bugs = Bug.new
        @devs = @project.users.where(user_type: 'Developer')
    end

    def index
        @bugs = Bug.where(created_id: current_user.id).paginate(page: params[:page], per_page: 5) if is_qa?
        @bugs = Bug.where(assign_id: current_user.id).paginate(page: params[:page], per_page: 5) if is_developer?
        @bugs = @project.bugs.paginate(page: params[:page], per_page: 5) if is_manager?
    end

    def edit
        # @devs = 
    end


    def create
        @bug = @project.bugs.build(bug_params)
        @bug.created_id = current_user.id
        if @bug.save
            flash[:success] = "Bug created successfully."
            redirect_to project_bugs_path
        else
            flash[:danger] = "Bug was not created."
            render 'new', status: 300
        end
    end

    def show
        @project = @bug.project
    end

    def update
        byebug
        if @bug.update(bug_params)
            flash[:success] = "Bug updated successfully."
            redirect_to projects_path
        else
            render 'edit', status: 300
        end
    end

    def destroy
        if @bug.destroy
            flash[:danger] = "Bug deleted successfully."
            redirect_to project_bugs_path
        else
            render 'show', status: 300
        end
    end

    def user
        @bugs = Bug.where(assign_id: params[:id]).paginate(page: params[:page], per_page: 5) if is_developer?
        @bugs = Bug.where(created_id: params[:id]).paginate(page: params[:page], per_page: 5) if is_qa?
        # byebug
        @bugs = Project.find_by(user_id: params[:id]).bugs.paginate(page: params[:page], per_page: 5) if is_manager?
    end

    private

        def find_bug
            @bug = Bug.find(params[:id])
        end

        def bug_params
            # p = params.require(:bug).permit(:title, :description, :deadline, {screenshot: []}, :bug_type, :assign_id)
            p = params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :assign_id)
            p = params.require(:bug).permit(:bug_status) if is_developer?
            p
        end

        def find_project
            @project = Project.find(params[:project_id])
        end

end