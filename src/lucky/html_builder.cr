require "./tags/**"
require "./page_helpers/**"
require "./mount_component"

module Lucky::HTMLBuilder
  include Lucky::LinkHelpers
  include Lucky::FormHelpers
  include Lucky::SpecialtyTags
  include Lucky::Assignable
  include Lucky::AssetHelpers
  include Lucky::NumberToCurrency
  include Lucky::TextHelpers
  include Lucky::HTMLTextHelpers
  include Lucky::UrlHelpers
  include Lucky::TimeHelpers
  include Lucky::ForgeryProtectionHelpers
  include Lucky::MountComponent
  include Lucky::HelpfulParagraphError
  include Lucky::RenderIfDefined
  include Lucky::TagDefaults
  include Lucky::LiveReloadTag
  include Lucky::SvgInliner

  abstract def view : IO

  def html
    @html_renderer ||= Lucky::HTMLRenderer.new(view)
  end

  def perform_render : IO
    render
    view
  end

  private def merge_options(html_options, tag_attrs)
    options = {} of String => String | Lucky::AllowedInTags
    tag_attrs.each do |key, value|
      options[key.to_s] = value
    end

    html_options.each do |key, value|
      next if key == :boolean_attrs
      options[key.to_s] = value
    end

    options
  end

  # Outputs *content* and escapes it.
  #
  # ```
  # text("Hello") # => Hello
  # text("<div>") # => &lt;div&gt;
  # ```
  def text(content : String | Lucky::AllowedInTags) : Nil
    view << HTML.escape(content.to_s)
  end
end
