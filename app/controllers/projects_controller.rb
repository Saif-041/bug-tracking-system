class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :edit, :update]
    # before_action :validate_user, only: [:show, :create, :update, :destroy]

    def new
        @project = Project.new
    end

    def index
        @projects = Project.where(user_id: current_user.id)
        # byebug
    end

    def edit
    end

    def create
        # byebug
        @project = Project.new(project_params)
        @project.user_id = current_user.id
        if @project.save
            flash[:success] = "Project created successfully."
            redirect_to projects_path
        end
    end

    def show
    end

    def update
        if @project.update(project_params)
            flash[:success] = "Project updated successfully."
            redirect_to projects_path
        else
            render 'edit', status: 300
        end
    end

    def destroy
        byebug
        @project = Project.find(params[:id])
        if @project.destroy
            flash[:danger] = "Project deleted successfully."
            redirect_to projects_path
        else
            render 'show', status: 300
        end
    end

    private

        def find_project
            @project = Project.find(params[:id])
        end

        def project_params
            params.require(:project).permit(:name)
        end


end