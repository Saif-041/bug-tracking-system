class BugsController < ApplicationController
    before_action :find_bug, only: [:show, :edit, :update, :destroy]
    before_action :find_project, only: [:edit, :new, :show, :index]

    # before_action :validate_user, only: [:create, :update, :destroy]
    # before_action :remember_page, only: [:new, :index]

    def new
        @bug = @project.bugs.build()
        @bugs = Bug.new
    end

    def index
        @bugs = Bug.where(created_id: current_user.id) if is_qa?
        @bugs = Bug.where(assign_id: current_user.id)
    end

    def edit
    end


    def create
        @project = Project.find(params[:project_id])
        @bug = @project.bugs.build(bug_params)
        @bug.created_id = current_user.id
        byebug
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
        # @project = Project.find_by(id: (UserProject.find_by(user_id: current_user.id).project_id))
    end

    def update
        if @bug.update(bug_params) && @usr.save
            flash[:success] = "Bug updated successfully."
            redirect_to project_bugs_path
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

    private

        def find_bug
            @bug = Bug.find(params[:id])
        end

        def bug_params
            # params.require(:bug).permit(:title, :description, :deadline, :bug_type, :assign_id)
            params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :assign_id)
        end

        def find_project
            @project = Project.find(params[:project_id])
        end


end