module ProjectHelper
  # Method to create some valid and writable Projects params
  # This must be invalid because there is no registered task
  def create_project(options = {})
    project = Project.create({
      title: "a"*(Project::TITLE_MIN_LENGTH),
      description: "a"*(Project::DESCRIPTION_MIN_LENGTH),
      percentage: 0,
      level: Project::PERMITTED_LEVELS.first, # Returns the string "Easy"
      category: Project::PERMITTED_CATEGORIES.first, # Returns the string "Art"
      status: Project::PERMITTED_STATUS.first # Returns the string "Active"
    }.merge(options))

    return project
  end

  # Create a valid task to validate the project
  def create_task(options = {})
    task = Task.create({
      title: "a"*(Task::TITLE_MIN_LENGTH),
      difficult: Task::PERMITTED_FIBONACCI_VALUES.first,
      description: "a"*(Task::DESCRIPTION_MIN_LENGTH)
    }.merge(options))

    return task
  end

  # Create a valid project with a task
  def create_project_with_task(project_options: {}, task_options: {})
    project = create_project(project_options)
    task = create_task(task_options)
    project.tasks << task

    return project
  end
end
