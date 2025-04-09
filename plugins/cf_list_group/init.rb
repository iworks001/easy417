require 'redmine'

Redmine::Plugin.register :cf_list_group do
  name 'CF List Group Plugin'
  author 'mini'
  description '사용자 정의 필드의 List 항목을 그룹화하여 출력하는 플러그인'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  # 관리 메뉴에 CF group 메뉴 추가
  menu :admin_menu, :cf_list_group, { controller: 'cf_groups', action: 'index' }, caption: 'CF group', html: { class: 'icon icon-custom' }
end

