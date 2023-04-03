class ProjectsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    before_action :find_project, only: [:show, :edit, :update, :destroy]
    before_action :find_users, only: [:show, :edit, :update, :new]
    # before_action :validate_user, only: [:show, :create, :update, :destroy]
    # before_action :remember_page, only: [:show]

    def new
        @project = Project.new
    end

    def index
        @projects = Project.where(user_id: current_user.id).paginate(page: params[:page], per_page: 4) if is_manager?
        @projects = current_user.projects.paginate(page: params[:page], per_page: 4) if !is_manager?
    end

    def edit
    end

    def create
        @project = Project.new(project_params)
        @project.user_id = current_user.id
        if @project.save
            flash[:success] = "Project created successfully."
            redirect_to projects_path
        else
            flash[:danger] = "Project was not created."
            render 'new', status: 300
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

        def find_users            
            @dev = User.select("id,name").where(user_type: 'Developer')
            @dev.each do |developer|
                developer.name = "Developer - " + developer.name.capitalize
            end

            @qa = User.select("id,name").where(user_type: 'QA')
            @qa.each do |q|
                q.name = "QA - " + q.name.capitalize
            end

            @user = @dev + @qa
            
            byebug
        end

        def project_params            
            p = params.require(:project).permit(:name, {users: []})
            p["users"] = p["users"].reject(&:empty?).map(&:to_i)
            p["users"] = p["users"].map { |id| User.find(id) }
            p
        end

end