module ApplicationHelper
  def title
    main_title = "Word Box"
    if !@title.nil?
      main_title += " | #{@title}"
    end
    main_title
  end

  def logo 
    image_tag("word_box.png", :alt => "Word Box", :class => "round")
  end
end
