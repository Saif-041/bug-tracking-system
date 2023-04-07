# frozen_string_literal: true

# This class BugsController < ActionController
class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_qa, only: %i[new destroy]
  before_action :authenticate_manager, only: %i[edit update]
  before_action :find_bug, only: %i[show edit update destroy]
  before_action :find_project, only: %i[edit new show index create]
  before_action :find_devs, only: %i[new edit]
  before_action :bug?, only: %i[user feature]

  def new
    @bug = @project.bugs.build
  end

  def index
    @bugs = @project.bugs
    @bugs = @bugs.where(assign_id: current_user.id) if developer?
    @bugs = @bugs.where(created_id: current_user.id) if qa?
    @bugs = @bugs.order('updated_at DESC').paginate(page: params[:page], per_page: 4)
  end

  def edit() end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.created_id = current_user.id
    if @bug.save
      flash[:success] = 'Bug created successfully.'
      redirect_to project_bug_path(@bug.project,@bug)
    else
      flash[:danger] = 'Bug was not created. Bug Title should be unique.'
      render 'new', status: :multiple_choices
    end
  end

  def show
    @project = @bug.project
  end

  def update
    if @bug.update(bug_params)
      flash[:success] = 'Bug updated successfully.'
      redirect_to project_bug_path(@bug.project)
    else
      flash[:danger] = 'Bug was not updated.'
      render 'edit', status: :multiple_choices
    end
  end

  def destroy
    if @bug.destroy
      flash[:danger] = 'Bug deleted successfully.'
      redirect_to project_bugs_path
    else
      flash[:warning] = 'Bug was not deleted.'
      render 'show', status: :multiple_choices
    end
  end

  def user
    @bugs = find_bugs
    @bugs = @bugs.where(bug_type: 'Bug').paginate(page: params[:page], per_page: 4)
  end

  def feature
    @features = find_bugs
    @features = @features.order('updated_at DESC').where(bug_type: 'Feature').paginate(page: params[:page], per_page: 4)
  end

  private

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    return  params.require(:bug).permit(:bug_status) if developer?

    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :assign_id)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_devs
    @devs = @project.users.where(user_type: 'Developer') # used in view
  end

  def find_bugs
    return @bugs = Bug.where(assign_id: params[:id]) if developer?
    return @bugs = Bug.where(created_id: params[:id]) if qa?
    @bugs = Bug.where(created_id: params[:id])
    @proj = Project.where(user_id: params[:id]) if manager?
    @proj.each do |project|
      @bugs = @bugs + project.bugs
    end
    Bug.where(id: @bugs.map(&:id))
  end

  def authenticate_qa
    unless qa?
      flash[:warning] = 'You are not authorized to access this page.'
      redirect_to project_bugs_path
    end
  end

  def authenticate_manager
    if manager?
      flash[:warning] = 'You are not authorized to access this page.'
      redirect_to project_bugs_path
    end
  end

  def bug?
    @has_bug = Bug.find_by(assign_id: current_user.id)
  end
end
