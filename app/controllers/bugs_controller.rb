class BugsController < ApplicationController
    before_action :find_bug, only: [:show, :edit, :update, :destroy]
    # before_action :validate_user, only: [:create, :update, :destroy]

    def new
        @bug = Bug.new
    end

    def index
        @bugs = Bug.where(created_id: current_user.id)
        @project = Project.first
    end

    def edit
    end

    def create
        byebug
        @bug = Bug.new(bug_params)
        if @bug.save
            flash[:success] = "Bug created successfully."
            redirect_to bugs_path
        else
            flash[:danger] = "Bug was not created."
            render 'new', status: 300
        end
    end

    def show
        @project = Project.first
        # @project = Project.find_by(id: (UserProject.find_by(user_id: current_user.id).project_id))
    end

    def update
        if @bug.update(bug_params) && @usr.save
            flash[:success] = "Bug updated successfully."
            redirect_to bugs_path
        else
            render 'edit', status: 300
        end
    end

    def destroy
        if @bug.destroy
            flash[:danger] = "Bug deleted successfully."
            redirect_to bugs_path
        else
            render 'show', status: 300
        end
    end

    def populate_list
        type = params[:bugs_type]
        if type == "Bug"
            @list = 'Resolved'
        else
            @list = 'Completed'
        end
        respond_to do |format|
          format.json { render json: @list }
        end
    end

    private

        def find_bug
            @bug = Bug.find(params[:id])
        end

        def bug_params
            # params.require(:bug).permit(:title, :description, :deadline, {screenshot: []}, :type, :assign_id)
            params.require(:bug).permit(:title, :description, :deadline, :screenshot, :type, :assign_id)
        end


end