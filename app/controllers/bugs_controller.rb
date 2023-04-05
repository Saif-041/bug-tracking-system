# frozen_string_literal: true

# This class BugsController < ActionController
class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_qa, only: %i[new destroy]
  before_action :authenticate_manager, only: %i[edit update]
  before_action :find_bug, only: %i[show edit update destroy]
  before_action :find_project, only: %i[edit new show index create]
  before_action :bug?, only: %i[user feature]
  before_action :find_features, only: :feature
  before_action :find_bugs, only: :user

  def new
    @bug = @project.bugs.build
    @devs = @project.users.where(user_type: 'Developer') # used in view
  end

  def index
    @bugs = @project.bugs.where(assign_id: current_user.id) if developer?
    @bugs = @project.bugs.where(created_id: current_user.id) if qa?
    @bugs = @project.bugs if manager?
    @bugs = @bugs.order('updated_at DESC').paginate(page: params[:page], per_page: 4)
  end

  def edit() end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.created_id = current_user.id
    if @bug.save
      flash[:success] = 'Bug created successfully.'
      redirect_to project_bug_path(@bug)
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
    @bugs = @bugs.order('updated_at DESC').where(bug_type: 'Bug').paginate(page: params[:page], per_page: 4)
  end

  def feature
    @features = @features.order('updated_at DESC').where(bug_type: 'Feature').paginate(page: params[:page], per_page: 4)
  end

  private

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    p = params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type, :assign_id)
    p = params.require(:bug).permit(:bug_status) if developer?
    p
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_features
    @features = Bug.where(assign_id: params[:id]) if developer?
    @features = Bug.where(created_id: params[:id]) if qa?
    @features = Project.find_by(user_id: params[:id]).bugs if manager?
  end

  def find_bugs
    @bugs = Bug.where(assign_id: params[:id]) if developer?
    @bugs = Bug.where(created_id: params[:id]) if qa?
    @bugs = Project.find_by(user_id: params[:id]).bugs if manager?
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
