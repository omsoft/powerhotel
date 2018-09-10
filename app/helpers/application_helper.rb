module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "UalaTest"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # used as a block on views to initialize Presenters
  def present(model, presenter_class=nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end

  # Create and return a DIV with flash messages
  def rails_messages
      ret = ''
      %w{notice warning error message success alert}.each do |message|
        ret << content_tag(:div, flash[message.to_sym], :class => "alert " + "alert-"+message) if flash[message.to_sym] && !flash[message.to_sym].blank?
      end
      return raw(ret)
  end

end
