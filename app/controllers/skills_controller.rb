class SkillsController < ApplicationController
  before_filter :only_worker

  def index
    @skills = current_user.skills
  end

  def new
    @skill = Skill.new
  end

  def create
    if current_user.skills.create resource_params
      redirect_to_index :created
    else
      render 'new'
    end
  end

  def edit
    @skill = find_skill
  end

  def update
    skill = find_skill
    if skill.update resource_params
      redirect_to_index :updated
    else
      render 'edit'
    end
  end

  def destroy
    find_skill.destroy
    redirect_to_index :destroyed
  end


  private

  def redirect_to_index action
    redirect_to skills_path,
      flash: { success: "Skill #{action} successfully" }
  end

  def find_skill
    current_user.skills.find params[:id]
  end

  def resource_params
    params.require(:skill).permit(:name)
  end

  def only_worker
    unless current_user.worker?
      flash[:error] = 'You must be a worker to manage your skills'
      redirect_to dashboard_path
    end
  end
end
