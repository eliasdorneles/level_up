module UsersHelper
  FEED_LENGTH = 50
  FEEDABLE_OBJECTS = [Completion, Enrollment].freeze

  def feed_items_for(user)
    objects = FEEDABLE_OBJECTS.map { |klass| klass.decorated_feed_for(user) }
    objects.flatten.take(FEED_LENGTH)
  end

  def gravatar_for(user, size)
    gravatar_image_tag(user.email, alt: user.name, class: 'gravatar',
                       gravatar: { size: size, secure: request.ssl?,
                                   default: :identicon })
  end

  def progress_summary_for(user)
    ProgressSummary.new(user.enrollments.limit(1)).to_a
  end
end
