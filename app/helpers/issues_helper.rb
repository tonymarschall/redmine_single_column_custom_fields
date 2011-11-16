require_dependency 'issues_helper'

module SingleColumnCustomFieldsHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :render_custom_fields_rows, :single_column
    end
  end
  
  module InstanceMethods
    def render_custom_fields_rows_with_single_column(issue)
      return if issue.custom_field_values.empty?
      s = ""
      issue.custom_field_values.compact.each do |value|
		s << "<tr>\n"
        s << "\t<th>#{ h(value.custom_field.name) }:</th><td>#{ simple_format_without_paragraph(h(show_value(value))) }</td>\n"
		s << "</tr>\n"
      end
      s
    end

  end
end

IssuesHelper.send(:include, SingleColumnCustomFieldsHelperPatch)
