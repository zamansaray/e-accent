class WorkerSkillsController < ApplicationController
  before_filter :only_worker

  def index
    @worker_skills = current_user.skills
  end

  def new
    @skills = Skill.not_chosen current_user.skills
  end

  def create
    skill = Skill.find resource_params[:id]
    if current_user.skills << skill
      redirect_to_index :chosen
    else
      render 'new'
    end
  end

  def destroy
    skill = Skill.find params[:id]
    current_user.skills.destroy skill
    redirect_to_index :discarded
  end


  private

  def redirect_to_index action
    redirect_to worker_skills_path,
      flash: { success: "Skill #{action} successfully" }
  end

  def resource_params
    params.require(:worker_skill).permit(:id)
  end

  def only_worker
    unless current_user.worker?
      flash[:error] = 'You must be a worker to manage your skills'
      redirect_to dashboard_path
    end
  end
end
