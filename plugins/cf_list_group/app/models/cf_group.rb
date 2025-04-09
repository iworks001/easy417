class CfGroup < ActiveRecord::Base
  unloadable
  belongs_to :custom_field, class_name: 'CustomField'

  validates :name, presence: true
  validates :custom_field_id, presence: true
  validates :group_values, presence: true

  # group_values는 Array로 저장 (마이그레이션에서는 text 타입으로 생성 후 serialize)
  serialize :group_values, Array
end

