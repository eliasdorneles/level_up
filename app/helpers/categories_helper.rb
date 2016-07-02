module CategoriesHelper
  RESOURCE_CLASSES = {
    text: 'fa-file-text',
    video: 'fa-video-camera',
    tutorial: 'fa-code',
    book: 'fa-book',
    audio: 'fa-microphone',
  }.freeze

  def exercise_block_for(handle, &block)
    block = ExerciseBlock.new(@category, handle, &block)

    current_skills << block.skill
    render block
  end

  def exercise_link(exercise_name)
    link_to(exercise_name.titleize, exercise_url(exercise_name))
  end

  def current_skills
    @current_skills ||= []
  end

  def exercise_url(exercise)
    "http://github.com/jmmastey/level_up_exercises/tree/master/#{exercise}"
  end

  def resource_block(&block)
    block = ResourceBlock.new(&block)
    render block
  end

  def resource_classes(type)
    RESOURCE_CLASSES.fetch(type) { raise ArgumentError } + ' fa fa-fw'
  end

  def completion_classes(skill)
    if @skills.include? skill.id
      "btn btn-default completed"
    else
      "btn btn-default"
    end
  end

  def completion_classes_small(skill)
    if @skills.include? skill.id
      "fa-check-circle-o"
    else
      "fa-circle-o"
    end
  end

  def high_five
    ["Sweet!", "Awesome!", "Go you!", "Right on!", "Righteous!", "やった！",
     "You're a champ!", "Rockin' it. I knew you would.", "Bravo!", "Kudos!",
     "Get down with your bad self.", "Boom shakalaka!", "Yeah, buddy!"].sample
  end

  def user_is_stuck?(user, category)
    CourseActivity.new(user, category.course).user_is_stuck?
  end
end
