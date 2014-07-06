module UsersHelper

  FEEDABLE_OBJECTS = [ Completion ]

  def user_category_summary
    category_summary = CategorySummary.summarize_user(user)
    categories_from_enrollments = user.categories
    category_summary.select { |key,stats| categories_from_enrollments.include? key }
  end

  def user_feed_items
    FEEDABLE_OBJECTS.map { |klass| klass.feed_for(user) }.flatten
  end

  def render_feed_item(item)
    send "render_#{item_klass(item)}_feed_item", item
  end

  def feed_item_tags(item)
    send "#{item_klass(item)}_tags", item
  end

  def item_klass(item)
    item.class.to_s.downcase
  end

  def enrolled_courses
    @enrolled ||= user.courses
  end

  protected

  def render_completion_feed_item(completion)
    "Completed #{completion.skill.name}"
  end

  def completion_tags(completion)
    ["skill", "completed", completion.skill.handle]
  end

end
