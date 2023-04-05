# frozen_string_literal: true

# This class ProjectsController < ActionController
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :find_project, only: %i[show edit update destroy]
  before_action :find_users, only: %i[show edit update new]

  def new
    @project = Project.new
  end

  def index
    @projects = Project.where(user_id: current_user.id) if manager?
    @projects = current_user.projects unless manager?
    @projects = @projects.order('updated_at DESC').paginate(page: params[:page], per_page: 4)
  end

  def edit() end

  def create
    # @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      flash[:success] = 'Project created successfully.'
      redirect_to projects_path
    else
      flash[:danger] = 'Project was not created.'
      render 'new', status: :multiple_choices
    end
  end

  def show() end

  def update
    if @project.update(project_params)
      flash[:success] = 'Project updated successfully.'
      redirect_to project_path(@project)
    else
      flash[:danger] = 'Project was not updated.'
      render 'edit', status: :multiple_choices
    end
  end

  def destroy
    if @project.destroy
      flash[:danger] = 'Project deleted successfully.'
      redirect_to projects_path
    else
      render 'show', status: :multiple_choices
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def find_users
    @dev = User.select('id,name').where(user_type: 'Developer')
    @dev.each do |developer|
      developer.name = "Developer - #{developer.name.capitalize}"
    end

    @qa = User.select('id,name').where(user_type: 'QA')
    @qa.each do |q|
      q.name = "QA - #{q.name.capitalize}"
    end

    @user = @dev + @qa
  end

  def project_params
    p = params.require(:project).permit(:name, { users: [] })
    p['users'] = p['users'].reject(&:empty?).map(&:to_i)
    p['users'] = p['users'].map { |id| User.find(id) }
    p
  end
end
