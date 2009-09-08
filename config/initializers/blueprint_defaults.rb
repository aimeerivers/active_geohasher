module ActionView::Helpers::FormTagHelper
  def text_field_tag_with_blueprint_formatting(name, value = nil, options = {})
    text_field_tag_without_blueprint_formatting name, value, {:class => "text"}.merge(options)
  end
  alias_method_chain :text_field_tag, :blueprint_formatting
end

module ActionView::Helpers::FormHelper
  def text_field_with_blueprint_formatting(object_name, method, options = {})
    text_field_without_blueprint_formatting object_name, method, {:class => "text"}.merge(options)
  end
  alias_method_chain :text_field, :blueprint_formatting
end

