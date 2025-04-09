class CfListGroupHook < Redmine::Hook::ViewListener
  render_on :view_issues_show_details_bottom, partial: 'cf_groups/grouped_custom_fields'
end

