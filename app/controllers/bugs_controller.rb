class BugsController < ApplicationController
    before_action :authenticate_user!    
    before_action :authenticate_qa, only: [:new, :destroy]
    before_action :authenticate_manager, only: [:edit, :update]

    before_action :find_bug, only: [:show, :edit, :update, :destroy]
    before_action :find_project, only: [:edit, :new, :show, :index, :create]

    def new
        @bug = @project.bugs.build()
        @devs = @project.users.where(user_type: 'Developer') # used in view
    end

    def index
        @bugs = Bug.where(created_id: current_user.id) if is_qa?
        @bugs = Bug.where(assign_id: current_user.id) if is_developer?
        @bugs = @project.bugs if is_manager?
        @bugs = @bugs.order("updated_at DESC").paginate(page: params[:page], per_page: 4)
    end

    def edit
        # @devs = 
    end


    def create
        @bug = @project.bugs.build(bug_params)
        @bug.created_id = current_user.id
        # if !@bug.screenshot?
        #     flash[:danger] = "Screenshot file not supported (only png file allowed)."
        #     render 'new', status: 300
        # els
        if @bug.save
            flash[:success] = "Bug created successfully."
            redirect_to @bug.project
        else
            flash[:danger] = "Bug was not created. Bug Title should be unique."
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
            redirect_to project_bug_path(@bug)
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
        @bugs = Bug.where(assign_id: params[:id]) if is_developer?
        @bugs = Bug.where(created_id: params[:id]) if is_qa?
        @bugs = Project.find_by(user_id: params[:id]).bugs if is_manager?
        @bugs = @bugs.order("updated_at DESC").where(bug_type: "Bug").paginate(page: params[:page], per_page: 4)
    end

    def feature
        @features = Bug.where(assign_id: params[:id]) if is_developer?
        @features = Bug.where(created_id: params[:id]) if is_qa?
        @features = Project.find_by(user_id: params[:id]).bugs if is_manager?
        @features = @features.order("updated_at DESC").where(bug_type: "Feature").paginate(page: params[:page], per_page: 4)
    end

    private

        def find_bug
            @bug = Bug.find(params[:id])
        end

        def bug_params
            # params.require(:bug).permit(:title, :description, :deadline, {screenshot: []}, :bug_type, :assign_id)
            p = params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :assign_id)
            p = params.require(:bug).permit(:bug_status) if is_developer?
            p
        end

        def find_project
            @project = Project.find(params[:project_id])
        end

        def authenticate_qa
            if !is_qa?
                flash[:warning] = "You are not authorized to access this page."
                redirect_to project_bugs_path
            end
        end

        def authenticate_manager
            if is_manager?
                flash[:warning] = "You are not authorized to access this page."
                redirect_to project_bugs_path
            end
        end

end