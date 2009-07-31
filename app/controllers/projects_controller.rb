class ProjectsController < ResourceController::Base

  index.before do
    @left_projects, @right_projects = @projects.halve
  end

end
