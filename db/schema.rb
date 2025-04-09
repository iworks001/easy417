# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_10_144000) do

  create_table "attachment_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "attachment_id"
    t.integer "version"
    t.integer "container_id"
    t.string "container_type", limit: 30
    t.string "filename", default: ""
    t.string "disk_filename", default: ""
    t.bigint "filesize", default: 0
    t.string "content_type", default: ""
    t.string "digest", limit: 64, default: ""
    t.integer "author_id", default: 0
    t.datetime "created_on"
    t.string "description"
    t.string "disk_directory"
    t.datetime "updated_at"
    t.string "easy_external_id"
    t.integer "project_id"
    t.index ["attachment_id"], name: "index_attachment_versions_on_attachment_id"
  end

  create_table "attachments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "container_id"
    t.string "container_type", limit: 30
    t.string "filename", default: "", null: false
    t.string "disk_filename", default: "", null: false
    t.bigint "filesize", default: 0, null: false
    t.string "content_type", default: ""
    t.string "digest", limit: 64, default: "", null: false
    t.integer "downloads", default: 0, null: false
    t.integer "author_id", default: 0, null: false
    t.datetime "created_on"
    t.string "description"
    t.string "disk_directory"
    t.integer "version"
    t.string "category"
    t.string "easy_external_id"
    t.integer "project_id"
    t.index ["author_id"], name: "index_attachments_on_author_id"
    t.index ["container_id", "container_type"], name: "index_attachments_on_container_id_and_container_type"
    t.index ["created_on"], name: "index_attachments_on_created_on"
    t.index ["disk_filename"], name: "index_attachments_on_disk_filename"
  end

  create_table "auth_sources", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", limit: 30, default: "", null: false
    t.string "name", limit: 60, default: "", null: false
    t.string "host", limit: 60
    t.integer "port"
    t.string "account"
    t.string "account_password", default: ""
    t.string "base_dn"
    t.string "attr_login", limit: 30
    t.string "attr_firstname", limit: 30
    t.string "attr_lastname", limit: 30
    t.string "attr_mail", limit: 30
    t.boolean "onthefly_register", default: false, null: false
    t.boolean "tls", default: false, null: false
    t.text "filter", limit: 16777215
    t.integer "timeout"
    t.string "easy_wsdl"
    t.text "easy_options", limit: 16777215
    t.boolean "verify_peer", default: true, null: false
    t.index ["id", "type"], name: "index_auth_sources_on_id_and_type"
  end

  create_table "boards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "name", default: "", null: false
    t.string "description"
    t.integer "position"
    t.integer "topics_count", default: 0, null: false
    t.integer "messages_count", default: 0, null: false
    t.integer "last_message_id"
    t.integer "parent_id"
    t.index ["last_message_id"], name: "index_boards_on_last_message_id"
    t.index ["project_id"], name: "boards_project_id"
  end

  create_table "cf_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "custom_field_id", null: false
    t.text "group_values"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "changes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "changeset_id", null: false
    t.string "action", limit: 1, default: "", null: false
    t.text "path", limit: 16777215, null: false
    t.text "from_path", limit: 16777215
    t.string "from_revision"
    t.string "revision"
    t.string "branch"
    t.index ["changeset_id"], name: "changesets_changeset_id"
  end

  create_table "changeset_parents", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "changeset_id", null: false
    t.integer "parent_id", null: false
    t.index ["changeset_id"], name: "changeset_parents_changeset_ids"
    t.index ["parent_id"], name: "changeset_parents_parent_ids"
  end

  create_table "changesets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "repository_id", null: false
    t.string "revision", null: false
    t.string "committer"
    t.datetime "committed_on", null: false
    t.text "comments", limit: 4294967295
    t.date "commit_date"
    t.string "scmid"
    t.integer "user_id"
    t.index ["committed_on"], name: "index_changesets_on_committed_on"
    t.index ["repository_id", "revision"], name: "changesets_repos_rev", unique: true
    t.index ["repository_id", "scmid"], name: "changesets_repos_scmid"
    t.index ["repository_id"], name: "index_changesets_on_repository_id"
    t.index ["user_id"], name: "index_changesets_on_user_id"
  end

  create_table "changesets_issues", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "changeset_id", null: false
    t.integer "issue_id", null: false
    t.index ["changeset_id", "issue_id"], name: "changesets_issues_ids", unique: true
    t.index ["issue_id"], name: "index_changesets_issues_on_issue_id"
  end

  create_table "comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "commented_type", limit: 30, default: "", null: false
    t.integer "commented_id", default: 0, null: false
    t.integer "author_id", default: 0, null: false
    t.text "content", limit: 16777215
    t.datetime "created_on", null: false
    t.datetime "updated_on", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["commented_id", "commented_type"], name: "index_comments_on_commented_id_and_commented_type"
  end

  create_table "custom_field_enumerations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.integer "position", default: 1, null: false
  end

  create_table "custom_field_mappings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.string "format_type", null: false
    t.string "group_name"
    t.string "name", null: false
  end

  create_table "custom_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", default: "", null: false
    t.string "name", limit: 30, default: "", null: false
    t.string "field_format", limit: 30, default: "", null: false
    t.text "possible_values", limit: 16777215
    t.string "regexp", default: ""
    t.integer "min_length"
    t.integer "max_length"
    t.boolean "is_required", default: false, null: false
    t.boolean "is_for_all", default: false, null: false
    t.boolean "is_filter", default: false, null: false
    t.integer "position"
    t.boolean "searchable", default: false
    t.text "default_value", limit: 16777215
    t.boolean "editable", default: true
    t.boolean "visible", default: true, null: false
    t.boolean "multiple", default: false
    t.text "format_store", limit: 16777215
    t.text "description", limit: 16777215
    t.boolean "is_primary", default: true, null: false
    t.boolean "show_empty", default: true, null: false
    t.boolean "show_on_list", default: false, null: false
    t.string "easy_computed_token"
    t.text "settings", limit: 16777215
    t.boolean "non_deletable", default: false, null: false
    t.boolean "non_editable", default: false, null: false
    t.string "internal_name"
    t.boolean "show_on_more_form", default: true, null: false
    t.string "easy_external_id"
    t.boolean "disabled", default: false, null: false
    t.float "easy_min_value"
    t.float "easy_max_value"
    t.boolean "mail_notification", default: true
    t.integer "easy_group_id"
    t.boolean "clear_when_anonymize", default: false
    t.text "easy_custom_permissions", limit: 16777215
    t.boolean "dmsf_not_inheritable"
    t.index ["id", "type"], name: "index_custom_fields_on_id_and_type"
    t.index ["internal_name"], name: "index_custom_fields_on_internal_name", unique: true
  end

  create_table "custom_fields_easy_contact_type", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "easy_contact_type_id", null: false
    t.index ["custom_field_id", "easy_contact_type_id"], name: "idx_cfid_contacttypeid", unique: true
  end

  create_table "custom_fields_easy_contacts", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "easy_contacts_id", null: false
    t.index ["custom_field_id", "easy_contacts_id"], name: "idx_cfid_contactid", unique: true
  end

  create_table "custom_fields_easy_crm_case_status", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "easy_crm_case_status_id", null: false
    t.index ["custom_field_id", "easy_crm_case_status_id"], name: "idx_cfeccs_1", unique: true
    t.index ["custom_field_id"], name: "idx_cfeccs_2"
    t.index ["easy_crm_case_status_id"], name: "idx_cfeccs_3"
  end

  create_table "custom_fields_easy_groups", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "easy_contact_groups_id", null: false
    t.index ["custom_field_id", "easy_contact_groups_id"], name: "idx_cfid_contactgroupid", unique: true
  end

  create_table "custom_fields_easy_user_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "easy_user_type_id", null: false
    t.index ["custom_field_id", "easy_user_type_id"], name: "custom_fields_easy_user_types_ids", unique: true
  end

  create_table "custom_fields_enumerations", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "enumeration_id", null: false
    t.index ["custom_field_id", "enumeration_id"], name: "custom_fields_enumerations_ids", unique: true
  end

  create_table "custom_fields_projects", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", default: 0, null: false
    t.integer "project_id", default: 0, null: false
    t.index ["custom_field_id", "project_id"], name: "index_custom_fields_projects_on_custom_field_id_and_project_id", unique: true
  end

  create_table "custom_fields_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", null: false
    t.integer "role_id", null: false
    t.index ["custom_field_id", "role_id"], name: "custom_fields_roles_ids", unique: true
  end

  create_table "custom_fields_trackers", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id", default: 0, null: false
    t.integer "tracker_id", default: 0, null: false
    t.index ["custom_field_id", "tracker_id"], name: "index_custom_fields_trackers_on_custom_field_id_and_tracker_id", unique: true
  end

  create_table "custom_values", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "customized_type", limit: 30, default: "", null: false
    t.integer "customized_id", default: 0, null: false
    t.integer "custom_field_id", default: 0, null: false
    t.text "value", limit: 16777215
    t.string "easy_external_id"
    t.index ["custom_field_id"], name: "index_custom_values_on_custom_field_id"
    t.index ["customized_type", "customized_id"], name: "custom_values_customized"
    t.index ["value"], name: "easy_idx_custom_values_value", length: 20
  end

  create_table "custom_workflows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "before_save"
    t.text "after_save"
    t.string "name", default: "", null: false
    t.text "description"
    t.integer "position", default: 1
    t.boolean "is_for_all", default: false, null: false
    t.string "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: true, null: false
    t.string "observable", default: "issue", null: false
    t.text "shared_code"
    t.text "before_add"
    t.text "after_add"
    t.text "before_remove"
    t.text "after_remove"
    t.text "before_destroy"
    t.text "after_destroy"
  end

  create_table "custom_workflows_projects", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "project_id"
    t.integer "custom_workflow_id"
    t.index ["custom_workflow_id"], name: "index_custom_workflows_projects_on_custom_workflow_id"
    t.index ["project_id"], name: "index_custom_workflows_projects_on_project_id"
  end

  create_table "diagram_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "diagram_id"
    t.text "xml"
    t.string "attachment"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagrams", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "title"
    t.text "xml"
    t.string "attachment"
    t.integer "current_position", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dmsf_file_revision_accesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_file_revision_id", null: false
    t.integer "action", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dmsf_file_revision_id"], name: "index_dmsf_file_revision_accesses_on_dmsf_file_revision_id"
  end

  create_table "dmsf_file_revisions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_file_id", null: false
    t.integer "source_dmsf_file_revision_id"
    t.string "name", null: false
    t.string "disk_filename", null: false
    t.bigint "size"
    t.string "mime_type"
    t.string "title", null: false
    t.text "description"
    t.integer "workflow"
    t.integer "major_version", null: false
    t.integer "minor_version", null: false
    t.text "comment"
    t.integer "deleted", default: 0, null: false
    t.integer "deleted_by_user_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dmsf_workflow_id"
    t.integer "dmsf_workflow_assigned_by_user_id"
    t.datetime "dmsf_workflow_assigned_at"
    t.integer "dmsf_workflow_started_by_user_id"
    t.datetime "dmsf_workflow_started_at"
    t.string "digest", limit: 64, default: "", null: false
    t.index ["dmsf_file_id"], name: "index_dmsf_file_revisions_on_dmsf_file_id"
  end

  create_table "dmsf_files", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "dmsf_folder_id"
    t.string "name", null: false
    t.boolean "notification", default: false
    t.integer "deleted", default: 0, null: false
    t.integer "deleted_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dmsf_folder_id"], name: "index_dmsf_files_on_dmsf_folder_id"
    t.index ["project_id"], name: "index_dmsf_files_on_project_id"
  end

  create_table "dmsf_folder_permissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_folder_id"
    t.integer "object_id", null: false
    t.string "object_type", limit: 30, null: false
    t.index ["dmsf_folder_id"], name: "index_dmsf_folder_permissions_on_dmsf_folder_id"
  end

  create_table "dmsf_folders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "dmsf_folder_id"
    t.string "title", null: false
    t.text "description"
    t.boolean "notification", default: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deleted", default: 0, null: false
    t.integer "deleted_by_user_id"
    t.boolean "system", default: false, null: false
    t.index ["dmsf_folder_id"], name: "index_dmsf_folders_on_dmsf_folder_id"
    t.index ["project_id"], name: "index_dmsf_folders_on_project_id"
  end

  create_table "dmsf_links", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "target_project_id", null: false
    t.integer "target_id"
    t.string "target_type", limit: 10, null: false
    t.string "name", null: false
    t.integer "project_id", null: false
    t.integer "dmsf_folder_id"
    t.integer "deleted", default: 0, null: false
    t.integer "deleted_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "external_url"
    t.integer "user_id"
    t.index ["dmsf_folder_id"], name: "index_dmsf_links_on_dmsf_folder_id"
    t.index ["project_id"], name: "index_dmsf_links_on_project_id"
  end

  create_table "dmsf_locks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entity_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_type", null: false
    t.integer "lock_type_cd", null: false
    t.integer "lock_scope_cd", null: false
    t.string "uuid", limit: 36
    t.datetime "expires_at"
    t.integer "dmsf_file_last_revision_id"
    t.string "owner"
    t.index ["entity_id", "entity_type"], name: "index_dmsf_locks_on_entity_id_and_entity_type"
  end

  create_table "dmsf_public_urls", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "token", limit: 32, null: false
    t.integer "dmsf_file_id", null: false
    t.integer "user_id", null: false
    t.datetime "expire_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["token"], name: "index_dmsf_public_urls_on_token"
  end

  create_table "dmsf_workflow_step_actions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_workflow_step_assignment_id", null: false
    t.integer "action", null: false
    t.text "note"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "author_id", null: false
    t.index ["dmsf_workflow_step_assignment_id"], name: "idx_dmsf_wfstepact_on_wfstepassign_id"
  end

  create_table "dmsf_workflow_step_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_workflow_step_id", null: false
    t.integer "user_id", null: false
    t.integer "dmsf_file_revision_id", null: false
    t.index ["dmsf_workflow_step_id", "dmsf_file_revision_id"], name: "index_dmsf_wrkfl_step_assigns_on_wrkfl_step_id_and_frev_id", unique: true
  end

  create_table "dmsf_workflow_steps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dmsf_workflow_id", null: false
    t.integer "step", null: false
    t.integer "user_id", null: false
    t.integer "operator", null: false
    t.string "name", limit: 30
    t.index ["dmsf_workflow_id"], name: "index_dmsf_workflow_steps_on_dmsf_workflow_id"
  end

  create_table "dmsf_workflows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "project_id"
    t.integer "status", default: 1, null: false
    t.timestamp "updated_on"
    t.datetime "created_on"
    t.integer "author_id"
  end

  create_table "documents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", default: 0, null: false
    t.integer "category_id", default: 0, null: false
    t.string "title", default: "", null: false
    t.text "description", limit: 4294967295
    t.datetime "created_on"
    t.string "easy_external_id"
    t.index ["category_id"], name: "index_documents_on_category_id"
    t.index ["created_on"], name: "index_documents_on_created_on"
    t.index ["project_id"], name: "documents_project_id"
  end

  create_table "easy_action_check_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "action_class", null: false
    t.text "action_settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_action_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_check_template_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.integer "status", default: 0, null: false
    t.text "result", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_action_check_template_id"], name: "idx_eac_1_202002"
    t.index ["entity_type", "entity_id"], name: "index_easy_action_checks_on_entity_type_and_entity_id"
  end

  create_table "easy_action_sequence_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_action_sequence_instances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_sequence_id", null: false
    t.bigint "current_easy_action_state_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.integer "status", default: 0, null: false
    t.text "settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_easy_action_state_id"], name: "idx_easi_2_20190926"
    t.index ["easy_action_sequence_id"], name: "idx_easi_1_20190926"
    t.index ["entity_type", "entity_id"], name: "idx_easi_3_20190926"
    t.index ["status"], name: "idx_easi_4_20190926"
  end

  create_table "easy_action_sequence_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.bigint "easy_action_sequence_category_id"
    t.string "target_entity_class", null: false
    t.string "condition_class"
    t.text "condition_settings", limit: 16777215
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_easy_action_sequence_templates_on_author_id"
    t.index ["easy_action_sequence_category_id"], name: "idx_east_1_20191218"
    t.index ["target_entity_class"], name: "index_easy_action_sequence_templates_on_target_entity_class"
  end

  create_table "easy_action_sequences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_sequence_template_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_easy_action_sequences_on_author_id"
    t.index ["easy_action_sequence_template_id"], name: "index_easy_action_sequences_on_easy_action_sequence_template_id"
    t.index ["entity_type", "entity_id"], name: "idx_eas_1_20191218"
  end

  create_table "easy_action_state_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_sequence_template_id", null: false
    t.bigint "easy_action_state_id", null: false
    t.string "name", null: false
    t.string "action_class", null: false
    t.text "action_settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_action_sequence_template_id"], name: "idx_easa_1_20190926"
    t.index ["easy_action_state_id"], name: "index_easy_action_state_actions_on_easy_action_state_id"
  end

  create_table "easy_action_states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_sequence_template_id", null: false
    t.string "name", null: false
    t.boolean "initial", default: false, null: false
    t.index ["easy_action_sequence_template_id"], name: "index_easy_action_states_on_easy_action_sequence_template_id"
    t.index ["initial"], name: "index_easy_action_states_on_initial"
  end

  create_table "easy_action_transitions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_action_sequence_template_id", null: false
    t.string "name", null: false
    t.bigint "state_from_id", null: false
    t.bigint "state_to_id", null: false
    t.string "condition_class", null: false
    t.text "condition_settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_action_sequence_template_id"], name: "idx_eat_3_20190926"
    t.index ["state_from_id"], name: "idx_eat_1_20190926"
    t.index ["state_to_id"], name: "idx_eat_2_20190926"
  end

  create_table "easy_active_job_statistics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "planned_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "duration", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_easy_active_job_statistics_on_name", unique: true
  end

  create_table "easy_agile_backlog_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "issue_id"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["issue_id"], name: "index_easy_agile_backlog_relations_on_issue_id"
    t.index ["project_id"], name: "index_easy_agile_backlog_relations_on_project_id"
  end

  create_table "easy_alert_contexts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "position"
  end

  create_table "easy_alert_reports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "alert_id", null: false
    t.integer "entity_id"
    t.string "entity_type"
    t.boolean "archived", default: false
    t.boolean "emailed", default: false
    t.datetime "created_on"
    t.integer "user_id", null: false
    t.datetime "expires_at"
    t.datetime "emailed_on"
    t.index ["alert_id"], name: "index_easy_alert_reports_on_alert_id"
    t.index ["emailed"], name: "index_easy_alert_reports_on_emailed"
    t.index ["entity_id", "entity_type"], name: "index_easy_alert_reports_on_entity"
    t.index ["user_id"], name: "index_easy_alert_reports_on_user_id"
  end

  create_table "easy_alert_reports_sys", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "generated", null: false
  end

  create_table "easy_alert_rules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "context_id", null: false
    t.string "class_name", default: "", null: false
    t.integer "position"
  end

  create_table "easy_alert_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "position"
    t.string "color", default: "", null: false
    t.boolean "is_deletable", default: true, null: false
    t.boolean "is_default", default: false, null: false
  end

  create_table "easy_alerts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "type_id", null: false
    t.integer "rule_id", null: false
    t.text "rule_settings", limit: 16777215
    t.integer "position"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "name", default: "", null: false
    t.datetime "nextrun_at"
    t.string "is_for", default: "only_me", null: false
    t.integer "group_id"
    t.string "mail_for", default: "all", null: false
    t.integer "mail_group_id"
    t.integer "builtin", default: 0, null: false
    t.string "mail", limit: 2048
    t.text "period_options", limit: 16777215
    t.index ["builtin"], name: "index_easy_alerts_on_builtin"
  end

  create_table "easy_attendance_activities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position"
    t.boolean "at_work", default: false
    t.boolean "is_default", default: false, null: false
    t.string "internal_name"
    t.boolean "non_deletable", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "project_mapping", default: false, null: false
    t.integer "mapped_project_id"
    t.integer "mapped_time_entry_activity_id"
    t.string "mail"
    t.string "color_schema"
    t.boolean "approval_required", default: false
    t.boolean "use_specify_time"
    t.boolean "system_activity", default: false
  end

  create_table "easy_attendance_activity_user_limits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_attendance_activity_id"
    t.integer "user_id"
    t.float "days", null: false
    t.float "accumulated_days", default: 0.0, null: false
    t.index ["easy_attendance_activity_id", "user_id"], name: "eaaul_eaa_id", unique: true
    t.index ["user_id"], name: "eaaul_u_id"
  end

  create_table "easy_attendance_user_arrival_notifies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "notify_to_id"
    t.text "message", limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["notify_to_id", "user_id"], name: "easy_attendance_user_arrival_notify_user_id_x_notify_id"
    t.index ["user_id", "notify_to_id"], name: "easy_attendance_user_arrival_notify_notify_id_x_user_id"
  end

  create_table "easy_attendances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "arrival"
    t.datetime "departure"
    t.integer "user_id", null: false
    t.integer "easy_attendance_activity_id"
    t.integer "edited_by_id"
    t.datetime "edited_when"
    t.boolean "locked", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "arrival_user_ip", default: "", null: false
    t.integer "time_entry_id"
    t.string "departure_user_ip", default: "", null: false
    t.integer "range"
    t.text "description", limit: 16777215
    t.integer "approval_status"
    t.integer "approved_by_id"
    t.datetime "approved_at"
    t.integer "previous_approval_status", limit: 1
    t.float "arrival_latitude"
    t.float "arrival_longitude"
    t.float "departure_latitude"
    t.float "departure_longitude"
    t.string "time_zone", limit: 6
    t.string "easy_external_id"
    t.float "hours", default: 0.0, null: false
    t.index ["approved_by_id"], name: "idx_ea_ab_id"
    t.index ["arrival", "departure"], name: "idx_ea_ar_de"
    t.index ["time_entry_id"], name: "idx_ea_time_entry_id"
    t.index ["user_id", "departure"], name: "index_easy_attendances_on_user_id_and_departure"
    t.index ["user_id"], name: "index_easy_attendances_on_user_id"
  end

  create_table "easy_avatars", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id", null: false
    t.string "entity_type", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["entity_id"], name: "index_easy_avatars_on_entity_id"
    t.index ["entity_type", "entity_id"], name: "index_easy_avatars_on_entity_type_and_entity_id", unique: true
  end

  create_table "easy_baseline_sources", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "baseline_id"
    t.integer "source_id"
    t.integer "destination_id"
    t.string "relation_type"
    t.index ["baseline_id"], name: "index_easy_baseline_sources_on_baseline_id"
  end

  create_table "easy_broadcasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "message", limit: 16777215, null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_at"], name: "index_easy_broadcasts_on_end_at"
    t.index ["start_at"], name: "index_easy_broadcasts_on_start_at"
  end

  create_table "easy_broadcasts_user_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_broadcast_id"
    t.integer "easy_user_type_id"
    t.index ["easy_broadcast_id", "easy_user_type_id"], name: "idx_easy_broadcast_user_type", unique: true
    t.index ["easy_user_type_id"], name: "index_easy_broadcasts_user_types_on_easy_user_type_id"
  end

  create_table "easy_buttons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "entity_type", null: false
    t.integer "project_id"
    t.boolean "active", default: true, null: false
    t.text "conditions", limit: 4294967295
    t.text "actions", limit: 4294967295
    t.text "conditions_cache", limit: 4294967295
    t.text "actions_cache", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "author_id"
    t.boolean "is_private", default: false
    t.boolean "silent_mode", default: true
    t.string "color"
    t.boolean "deleted", default: false
    t.text "entity_note", limit: 4294967295
  end

  create_table "easy_calculation_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "name"
    t.decimal "hours", precision: 30, scale: 2
    t.decimal "rate", precision: 30, scale: 2
    t.decimal "calculation_position", precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "value", precision: 30, scale: 2
    t.string "unit"
    t.integer "calculation_discount"
    t.boolean "calculation_discount_is_percent", default: false, null: false
    t.index ["project_id"], name: "index_easy_calculation_items_on_project_id"
  end

  create_table "easy_calculations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.text "top_description", limit: 4294967295
    t.text "bottom_description", limit: 4294967295
    t.string "project_status"
    t.string "supplier_name"
    t.string "supplier_tel"
    t.string "supplier_mail"
    t.string "manager_name"
    t.string "manager_tel"
    t.string "manager_mail"
    t.string "title"
    t.index ["project_id"], name: "index_easy_calculations_on_project_id"
  end

  create_table "easy_cash_desk_transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_cash_desk_id", null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.date "spent_on"
    t.text "description", limit: 16777215
    t.integer "author_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.string "currency"
    t.boolean "is_template", default: false
    t.text "repeating_preferences", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "easy_is_repeating"
    t.text "easy_repeat_settings", limit: 4294967295
    t.date "easy_next_start"
  end

  create_table "easy_cash_desks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.integer "position"
    t.boolean "is_default", default: false, null: false
    t.string "currency"
    t.integer "project_id"
    t.integer "parent_id"
    t.integer "author_id"
    t.string "internal_name"
    t.boolean "non_deletable", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_chart_baselines", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "page_module_id"
    t.string "name"
    t.string "chart_type"
    t.text "data", limit: 16777215
    t.text "ticks", limit: 16777215
    t.text "options", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_checklist_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "subject"
    t.integer "position"
    t.boolean "done", default: false
    t.integer "author_id", null: false
    t.integer "changed_by_id"
    t.datetime "last_done_change"
    t.integer "easy_checklist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_checklists", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "author_id", null: false
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "settings", limit: 4294967295
    t.boolean "is_default_for_new_projects", default: false
    t.index ["entity_id", "entity_type"], name: "idx_ecl_entity_type_id"
    t.index ["id", "type"], name: "idx_ecl_type"
  end

  create_table "easy_contact_entity_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_contact_id", null: false
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["easy_contact_id", "entity_id", "entity_type"], name: "idx_contacts_assignments", unique: true
    t.index ["easy_contact_id"], name: "index_easy_contact_entity_assignments_on_easy_contact_id"
    t.index ["entity_type", "entity_id"], name: "idx_ecea_entity"
  end

  create_table "easy_contact_type", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type_name", null: false
    t.integer "position"
    t.boolean "is_default", default: false, null: false
    t.string "icon_path"
    t.string "internal_name"
    t.integer "fields_bits", default: 0
  end

  create_table "easy_contact_types_easy_user_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_contact_type_id", null: false
    t.integer "easy_user_type_id", null: false
    t.index ["easy_contact_type_id", "easy_user_type_id"], name: "idx_contact_vis_by_user", unique: true
  end

  create_table "easy_contacts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "author_note", limit: 16777215
    t.integer "type_id", null: false
    t.boolean "is_public", default: false, null: false
    t.integer "author_id", null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "firstname"
    t.string "lastname"
    t.boolean "is_global", default: true
    t.string "internal_name"
    t.boolean "non_deletable", default: false
    t.boolean "non_editable", default: false
    t.string "easy_external_id"
    t.string "uid"
    t.boolean "private", default: false
    t.float "latitude"
    t.float "longitude"
    t.integer "parent_id"
    t.integer "root_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "assigned_to_id"
    t.string "easy_avatar_url"
    t.index ["assigned_to_id"], name: "index_easy_contacts_on_assigned_to_id"
    t.index ["author_id"], name: "index_easy_contacts_on_author_id"
    t.index ["parent_id"], name: "idx_contacts_parent_id"
    t.index ["private"], name: "index_easy_contacts_on_private"
    t.index ["root_id", "lft", "rgt"], name: "idx_contacts_tree"
    t.index ["type_id"], name: "index_easy_contacts_on_type_id"
  end

  create_table "easy_contacts_group_assignments", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "contact_id", null: false
    t.index ["contact_id", "group_id"], name: "idx_contacts_groups", unique: true
    t.index ["contact_id"], name: "index_easy_contacts_group_assignments_on_contact_id"
  end

  create_table "easy_contacts_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "group_name", null: false
    t.text "author_note", limit: 16777215
    t.boolean "is_public", default: false, null: false
    t.integer "author_id", null: false
    t.integer "parent_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "root_id"
  end

  create_table "easy_contacts_references", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "referenced_by", null: false
    t.integer "referenced_to", null: false
    t.index ["referenced_by", "referenced_to"], name: "idx_contacts_references", unique: true
  end

  create_table "easy_crm_case_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_crm_case_id"
    t.string "name", null: false
    t.string "description", limit: 2048
    t.decimal "total_price", precision: 30, scale: 2, default: "0.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "amount", precision: 30, scale: 2, default: "1.0", null: false
    t.string "product_code"
    t.string "unit"
    t.decimal "price_per_unit", precision: 30, scale: 2, default: "0.0", null: false
    t.integer "easy_price_book_product_price_id"
    t.decimal "discount", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "price_per_unit_EUR", precision: 32, scale: 4
    t.decimal "total_price_EUR", precision: 32, scale: 4
    t.integer "position"
    t.decimal "price_per_unit_USD", precision: 32, scale: 4
    t.decimal "total_price_USD", precision: 32, scale: 4
    t.string "easy_external_id"
    t.index ["easy_crm_case_id"], name: "idx_ecci_1"
  end

  create_table "easy_crm_case_mail_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "easy_crm_case_status_id"
    t.string "subject", limit: 2048, null: false
    t.text "body_html", limit: 16777215
    t.text "body_plain", limit: 16777215
  end

  create_table "easy_crm_case_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "internal_name"
    t.integer "position"
    t.boolean "is_default", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_easy_contact_required", default: false
    t.boolean "is_closed", default: false
    t.boolean "is_won", default: false
    t.boolean "is_paid", default: false
    t.boolean "show_in_search_results", default: false
    t.boolean "only_for_admin", default: false
    t.index ["internal_name"], name: "idx_easy_crm_case_statuses_1"
  end

  create_table "easy_crm_cases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 4294967295
    t.integer "author_id", null: false
    t.integer "project_id", null: false
    t.integer "assigned_to_id"
    t.integer "easy_crm_case_status_id", null: false
    t.date "contract_date"
    t.string "email", limit: 2048
    t.string "telephone"
    t.decimal "price", precision: 30, scale: 2
    t.string "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "need_reaction", default: false, null: false
    t.datetime "next_action"
    t.integer "lock_version", default: 0, null: false
    t.boolean "is_canceled", default: false, null: false
    t.boolean "is_finished", default: false, null: false
    t.boolean "all_day", default: true, null: false
    t.integer "easy_last_updated_by_id"
    t.integer "easy_closed_by_id"
    t.datetime "closed_on"
    t.integer "lead_value"
    t.integer "probability"
    t.decimal "price_EUR", precision: 32, scale: 4
    t.integer "main_easy_contact_id"
    t.decimal "price_USD", precision: 32, scale: 4
    t.string "email_cc", limit: 2048
    t.string "easy_external_id"
    t.index ["assigned_to_id"], name: "idx_easy_crm_cases_3"
    t.index ["author_id"], name: "idx_easy_crm_cases_1"
    t.index ["contract_date"], name: "idx_easy_crm_cases_5"
    t.index ["easy_crm_case_status_id"], name: "idx_easy_crm_cases_4"
    t.index ["is_canceled"], name: "index_easy_crm_cases_on_is_canceled"
    t.index ["main_easy_contact_id"], name: "index_easy_crm_cases_on_main_easy_contact_id"
    t.index ["project_id"], name: "idx_easy_crm_cases_2"
    t.index ["updated_at"], name: "idx_easy_crm_cases_6"
  end

  create_table "easy_crm_cases_issues", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_crm_case_id", null: false
    t.integer "issue_id", null: false
    t.index ["easy_crm_case_id", "issue_id"], name: "idx_easy_crm_cases_issues_1", unique: true
  end

  create_table "easy_crm_country_values", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_easy_crm_country_values_on_country"
  end

  create_table "easy_crm_targets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.decimal "target", precision: 30, scale: 2, null: false
    t.datetime "valid_from", null: false
    t.datetime "valid_to", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_currencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso_code", limit: 3, null: false
    t.integer "digits_after_decimal_separator"
    t.string "symbol"
    t.boolean "activated"
    t.boolean "is_default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iso_code"], name: "index_easy_currencies_on_iso_code"
  end

  create_table "easy_currency_exchange_rates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.decimal "rate", precision: 18, scale: 6, default: "1.0", null: false
    t.integer "base_id"
    t.integer "to_id"
    t.date "valid_on"
    t.string "base_code", limit: 3
    t.string "to_code", limit: 3
    t.datetime "created_at", default: "2018-07-06 18:32:16"
    t.datetime "updated_at", default: "2018-07-06 18:32:16"
    t.index ["base_code", "to_code"], name: "idx_easy_exch_rates"
    t.index ["valid_on", "base_code", "to_code"], name: "idx_easy_exch_rates_valid_on"
  end

  create_table "easy_custom_field_ratings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_value_id", null: false
    t.integer "rating"
    t.text "description", limit: 16777215
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_custom_menus", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", limit: 2000, null: false
    t.integer "easy_user_type_id", null: false
    t.integer "root_id"
    t.string "easy_icon"
    t.integer "position"
    t.index ["easy_user_type_id"], name: "index_easy_custom_menus_on_easy_user_type_id"
  end

  create_table "easy_custom_project_menus", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "menu_item"
    t.string "name"
    t.string "url", limit: 2000
    t.integer "position", default: 1
    t.integer "project_id", null: false
  end

  create_table "easy_data_template_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_data_template_id", null: false
    t.string "entity_attribute_name", null: false
    t.integer "file_column_position", null: false
  end

  create_table "easy_data_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id"
    t.string "template_type", limit: 50, null: false
    t.text "settings", limit: 16777215
    t.integer "author_id", null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "format_type", null: false
    t.string "type", null: false
  end

  create_table "easy_default_query_mappings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.string "entity_type", null: false
    t.integer "position"
    t.integer "easy_query_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "role_id"], name: "edqm_role_type"
  end

  create_table "easy_dependent_custom_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "custom_field_id"
    t.integer "dependency_id"
    t.string "dependency_type", default: "CustomField"
    t.integer "order", limit: 2, default: 0
    t.integer "relation"
    t.index ["custom_field_id", "dependency_type", "dependency_id"], name: "idx_easy_dependent_custom_fields_3", unique: true
    t.index ["dependency_id"], name: "index_easy_dependent_custom_fields_on_dependency_id"
    t.index ["dependency_type"], name: "index_easy_dependent_custom_fields_on_dependency_type"
  end

  create_table "easy_earned_value_data", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_earned_value_id"
    t.date "date"
    t.decimal "ev", precision: 10, scale: 2
    t.decimal "ac", precision: 10, scale: 2
    t.decimal "pv", precision: 10, scale: 2
  end

  create_table "easy_earned_values", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "baseline_id"
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "project_default", default: false
    t.boolean "data_initilized", default: false
    t.date "start_date"
    t.date "due_date"
    t.date "actual_reloaded_at"
    t.boolean "reload_constantly", default: false
  end

  create_table "easy_email_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "internal_name"
    t.string "subject", null: false
    t.text "body_html", limit: 16777215
    t.text "body_plain", limit: 16777215
  end

  create_table "easy_entities_with_currencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_class"
    t.date "initializaed_at"
    t.date "recalculated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_entity_action_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_entity_action_id", null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.text "text", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["easy_entity_action_id"], name: "index_eea_action_id"
    t.index ["entity_id", "entity_type"], name: "index_eea_entity_id_and_type"
  end

  create_table "easy_entity_actions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "action_name", null: false
    t.boolean "active", default: true, null: false
    t.integer "author_id", null: false
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "project_id"
    t.boolean "use_journal", default: false, null: false
    t.boolean "mail", default: false, null: false
    t.string "mail_sender"
    t.string "mail_cc"
    t.string "mail_bcc"
    t.string "mail_subject"
    t.text "mail_html_body", limit: 4294967295
    t.text "easy_query_settings", limit: 4294967295
    t.string "execute_as", null: false
    t.integer "execute_as_user_id"
    t.boolean "repeatedly", default: false, null: false
    t.text "period_options", limit: 4294967295
    t.datetime "last_executed"
    t.datetime "nextrun_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "settings", limit: 16777215
    t.text "setup_actions", limit: 16777215
    t.index ["entity_type", "entity_id"], name: "index_easy_entity_actions_on_entity_type_and_entity_id"
    t.index ["type"], name: "index_easy_entity_actions_on_type"
  end

  create_table "easy_entity_activities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id", null: false
    t.string "entity_type", null: false
    t.integer "author_id"
    t.integer "category_id", null: false
    t.boolean "is_finished", default: false
    t.text "description", limit: 16777215
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "all_day"
    t.datetime "end_time"
    t.index ["author_id"], name: "index_eea_on_author_id"
    t.index ["entity_type", "entity_id"], name: "index_eea_on_entity"
    t.index ["start_time"], name: "idx_eea_on_start_time"
  end

  create_table "easy_entity_activity_attendees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_entity_activity_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_entity_activity_id"], name: "index_eeaa_on_activity_id"
    t.index ["entity_type", "entity_id"], name: "index_eeaa_on_entity"
  end

  create_table "easy_entity_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_from_id"
    t.string "entity_from_type"
    t.integer "entity_to_id"
    t.string "entity_to_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["entity_from_id"], name: "entity_assignment_idx_from"
    t.index ["entity_from_type", "entity_from_id", "entity_to_type", "entity_to_id"], name: "entity_assignment_idx", unique: true
    t.index ["entity_to_id"], name: "entity_assignment_idx_to"
  end

  create_table "easy_entity_attribute_maps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_from_type", null: false
    t.string "entity_from_attribute", null: false
    t.string "entity_to_type", null: false
    t.string "entity_to_attribute", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_from_type", "entity_from_attribute", "entity_to_type"], name: "i_map_from_entity", unique: true
    t.index ["entity_from_type", "entity_to_type", "entity_to_attribute"], name: "i_map_to_entity", unique: true
  end

  create_table "easy_entity_import_attributes_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_entity_import_id", null: false
    t.string "source_attribute"
    t.string "entity_attribute", null: false
    t.boolean "is_custom", default: false, null: false
    t.string "value"
    t.text "default_value", limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "allow_find_by_external_id", default: false, null: false
    t.string "format"
    t.index ["easy_entity_import_id", "entity_attribute"], name: "ee_import_att_ass_entity_importer"
    t.index ["source_attribute", "entity_attribute"], name: "ee_import_att_ass_source_entity"
  end

  create_table "easy_entity_imports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "entity_type", null: false
    t.string "name", null: false
    t.string "api_url"
    t.boolean "is_automatic"
    t.text "settings", limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "merge_by", default: "easy_external_id"
  end

  create_table "easy_entity_sequence_step_entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_entity_sequence_step_id", null: false
    t.integer "position"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.text "filters", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "entity_settings", limit: 4294967295
    t.index ["easy_entity_sequence_step_id", "entity_type", "entity_id"], name: "idx_eesse_3", unique: true
    t.index ["easy_entity_sequence_step_id"], name: "idx_eesse_1"
    t.index ["position"], name: "idx_eesse_2"
  end

  create_table "easy_entity_sequence_steps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_entity_sequence_id", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["easy_entity_sequence_id"], name: "idx_eess_1"
    t.index ["position"], name: "idx_eess_2"
  end

  create_table "easy_entity_sequences", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position"
    t.integer "author_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "project_id"
    t.index ["position"], name: "idx_ees_1"
  end

  create_table "easy_external_authentications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "provider"
    t.string "access_token"
    t.string "access_secret"
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "issued_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], name: "index_easy_external_authentications_on_uid"
  end

  create_table "easy_external_synchronisations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "external_type"
    t.string "external_id"
    t.string "external_source", limit: 2048
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "status", null: false
    t.text "note", limit: 16777215
    t.datetime "synchronized_at", null: false
    t.string "direction", default: "in", null: false
    t.index ["entity_id"], name: "idx_easy_ext_sync_2"
    t.index ["entity_type", "entity_id"], name: "idx_easy_ext_sync_1", unique: true
  end

  create_table "easy_favorites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id", null: false
    t.string "entity_type", null: false
    t.integer "user_id"
    t.index ["entity_type", "entity_id", "user_id"], name: "favorite_idx", unique: true
    t.index ["user_id"], name: "index_easy_favorites_on_user_id"
  end

  create_table "easy_gantt_reservation_resources", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_gantt_reservation_id"
    t.date "date", null: false
    t.decimal "hours", precision: 6, scale: 1, null: false
  end

  create_table "easy_gantt_reservations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "assigned_to_id"
    t.integer "author_id"
    t.string "name"
    t.float "estimated_hours"
    t.date "start_date"
    t.date "due_date"
    t.string "allocator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description", limit: 16777215
    t.integer "project_id"
  end

  create_table "easy_gantt_resources", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id", null: false
    t.date "date", null: false
    t.decimal "hours", precision: 7, scale: 2, null: false
    t.boolean "custom", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "start"
    t.decimal "original_hours", precision: 7, scale: 2, default: "0.0"
    t.index ["date"], name: "index_easy_gantt_resources_on_date"
    t.index ["issue_id"], name: "index_easy_gantt_resources_on_issue_id"
    t.index ["user_id", "issue_id", "date", "start"], name: "unique_index_user_id_and_issue_id_and_date_and_start", unique: true
    t.index ["user_id"], name: "index_easy_gantt_resources_on_user_id"
  end

  create_table "easy_global_ratings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "customized_id"
    t.string "customized_type"
    t.float "value"
  end

  create_table "easy_global_time_entry_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "spent_on_limit_before_today"
    t.integer "spent_on_limit_before_today_edit"
    t.integer "spent_on_limit_after_today"
    t.integer "spent_on_limit_after_today_edit"
    t.boolean "timelog_comment_editor_enabled", default: false
    t.boolean "time_entry_spent_on_at_issue_update_enabled", default: false
    t.boolean "allow_log_time_to_closed_issue", default: false
    t.boolean "required_issue_id_at_time_entry", default: false
    t.boolean "show_time_entry_range_select", default: false
    t.integer "time_entry_daily_limit"
    t.boolean "required_time_entry_comments", default: false
  end

  create_table "easy_google_ads_campaigns", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.string "name", null: false
    t.string "product"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_easy_google_ads_campaigns_on_campaign_id"
    t.index ["campaign_id"], name: "uniq_index_campaign_id", unique: true
  end

  create_table "easy_google_ads_geo_performances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.date "date", null: false
    t.string "country", limit: 3
    t.decimal "cost", precision: 10, scale: 2
    t.integer "clicks"
    t.decimal "cost_EUR", precision: 32, scale: 4
    t.decimal "cost_USD", precision: 32, scale: 4
    t.index ["campaign_id"], name: "index_easy_google_ads_geo_performances_on_campaign_id"
    t.index ["country"], name: "index_easy_google_ads_geo_performances_on_country"
    t.index ["date"], name: "index_easy_google_ads_geo_performances_on_date"
  end

  create_table "easy_helpdesk_auto_issue_closers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_helpdesk_project_id"
    t.integer "observe_issue_status_id"
    t.integer "done_issue_status_id"
    t.decimal "inactive_interval", precision: 8, scale: 2
    t.integer "inactive_interval_unit", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "done_issue_user_id"
    t.text "auto_update_modes"
    t.integer "easy_helpdesk_mail_template_id"
  end

  create_table "easy_helpdesk_mail_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "subject", limit: 2048, null: false
    t.text "body_html", limit: 16777215
    t.text "body_plain", limit: 16777215
    t.integer "issue_status_id"
    t.string "reply_to", limit: 2048
    t.string "name", default: "", null: false
  end

  create_table "easy_helpdesk_mail_templates_mailboxes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "mail_template_id", null: false
    t.integer "mailbox_id", null: false
  end

  create_table "easy_helpdesk_project_matchings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_helpdesk_project_id", null: false
    t.string "domain_name", null: false
    t.string "email_field", default: "from", null: false
  end

  create_table "easy_helpdesk_project_slas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_helpdesk_project_id", null: false
    t.string "keyword", default: "", null: false
    t.float "hours_to_solve", default: 0.0, null: false
    t.integer "priority_id"
    t.float "hours_to_response", default: 0.0, null: false
    t.string "hours_mode_from", default: "00:00", null: false
    t.string "hours_mode_to", default: "24:00", null: false
    t.integer "tracker_id"
    t.integer "easy_user_working_time_calendar_id"
    t.boolean "use_working_time", default: false, null: false
    t.integer "position", default: 0
    t.string "title"
  end

  create_table "easy_helpdesk_projects", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "tracker_id", null: false
    t.integer "assigned_to_id"
    t.float "monthly_hours"
    t.boolean "monitor_due_date", default: true, null: false
    t.boolean "monitor_spent_time", default: true, null: false
    t.integer "default_for_mailbox_id"
    t.text "watchers_ids", limit: 16777215
    t.text "email_header", limit: 16777215
    t.text "email_footer", limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "aggregated_hours", default: false, null: false
    t.float "aggregated_hours_remaining"
    t.string "aggregated_hours_period"
    t.date "aggregated_hours_start_date"
    t.date "aggregated_hours_last_reset"
    t.date "aggregated_hours_last_update"
    t.string "keyword", default: "", null: false
    t.boolean "automatically_issue_closer_enable", default: false
    t.text "watcher_groups_ids"
    t.index ["project_id"], name: "index_easy_helpdesk_projects_on_project_id"
  end

  create_table "easy_hosting_plugins", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "plugin_name", null: false
    t.boolean "activated", default: false, null: false
    t.integer "activated_by"
    t.datetime "activated_to"
    t.integer "trial_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["activated"], name: "idx_ehp_plugin_name_2"
    t.index ["plugin_name"], name: "idx_ehp_plugin_name_1", unique: true
  end

  create_table "easy_icalendar_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "summary", limit: 16777215
    t.integer "easy_icalendar_id"
    t.string "uid", null: false
    t.datetime "dtstart", null: false
    t.datetime "dtend"
    t.text "description", limit: 16777215
    t.string "location"
    t.string "organizer"
    t.string "url"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_icalendar_id"], name: "index_easy_icalendar_events_on_easy_icalendar_id"
  end

  create_table "easy_icalendars", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "easy_color_scheme"
    t.integer "visibility", default: 0
    t.datetime "synchronized_at"
    t.datetime "last_run_at"
    t.integer "status", default: 0
    t.text "message", limit: 16777215
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_easy_icalendars_on_user_id"
  end

  create_table "easy_instant_messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "content", limit: 16777215
    t.string "sender_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "unread", default: true
    t.index ["recipient_id", "sender_id"], name: "index_easy_instant_messages_on_recipient_id_and_sender_id"
    t.index ["recipient_id", "unread"], name: "index_easy_instant_messages_on_recipient_id_and_unread"
    t.index ["sender_id", "recipient_id"], name: "index_easy_instant_messages_on_sender_id_and_recipient_id"
  end

  create_table "easy_integration_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_integration_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.integer "status", default: 0, null: false
    t.string "action", null: false
    t.text "return_value", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_integration_id", "entity_id"], name: "idx_eil_integration_entity"
    t.index ["easy_integration_id"], name: "index_easy_integration_logs_on_easy_integration_id"
    t.index ["entity_type", "entity_id"], name: "index_easy_integration_logs_on_entity_type_and_entity_id"
  end

  create_table "easy_integrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "metadata_klass", null: false
    t.json "metadata_settings", null: false
    t.string "service_klass", null: false
    t.string "entity_klass", null: false
    t.boolean "active", default: true, null: false
    t.boolean "perform_once", default: true, null: false
    t.boolean "on_create", default: true, null: false
    t.boolean "on_update", default: false, null: false
    t.boolean "on_destroy", default: false, null: false
    t.boolean "on_time", default: false, null: false
    t.boolean "use_query", default: false, null: false
    t.json "query_settings"
    t.integer "execute_as_user_id"
    t.boolean "use_journal", default: false, null: false
    t.boolean "grouped_notify", default: false, null: false
    t.string "cron_expr"
    t.datetime "next_run_at"
    t.bigint "easy_oauth2_client_application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_easy_integrations_on_active"
    t.index ["easy_oauth2_client_application_id"], name: "index_easy_integrations_on_easy_oauth2_client_application_id"
    t.index ["entity_klass"], name: "index_easy_integrations_on_entity_klass"
    t.index ["next_run_at"], name: "index_easy_integrations_on_next_run_at"
    t.index ["on_create"], name: "index_easy_integrations_on_on_create"
    t.index ["on_destroy"], name: "index_easy_integrations_on_on_destroy"
    t.index ["on_time"], name: "index_easy_integrations_on_on_time"
    t.index ["on_update"], name: "index_easy_integrations_on_on_update"
  end

  create_table "easy_invitations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_meeting_id"
    t.integer "user_id"
    t.boolean "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "alarms", limit: 4294967295
    t.index ["easy_meeting_id"], name: "index_easy_invitations_on_easy_meeting_id"
    t.index ["user_id"], name: "index_easy_invitations_on_user_id"
  end

  create_table "easy_invoice_line_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_invoice_id"
    t.text "name", limit: 16777215
    t.decimal "unit_price", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "quantity", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "vat_rate", precision: 30, scale: 2, default: "0.0", null: false
    t.string "unit_name"
    t.boolean "with_vat", default: false, null: false
    t.integer "easy_price_book_product_price_id"
    t.decimal "discount", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "unit_price_EUR", precision: 32, scale: 4
    t.decimal "unit_price_USD", precision: 32, scale: 4
    t.string "easy_external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["easy_invoice_id"], name: "idx_einvoice_items_1"
  end

  create_table "easy_invoice_sequences", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "format"
    t.integer "number", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_invoice_vat_registrations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_contact_id"
    t.string "country_code", limit: 2
    t.date "valid_from"
    t.date "valid_until"
  end

  create_table "easy_invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "number"
    t.date "issued_at"
    t.datetime "sent_at"
    t.date "paid_at"
    t.datetime "due_at"
    t.datetime "accepted_at"
    t.datetime "cancelled_at"
    t.date "taxable_fulfillment_due_at"
    t.text "note", limit: 16777215
    t.text "footer_note", limit: 16777215
    t.text "private_note", limit: 16777215
    t.decimal "paid_amount", precision: 30, scale: 2, default: "0.0", null: false
    t.string "bank_account"
    t.string "swift"
    t.string "iban"
    t.string "variable_symbol"
    t.decimal "subtotal", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "total", precision: 30, scale: 2, default: "0.0", null: false
    t.integer "client_id"
    t.string "client_registration_no"
    t.string "client_vat_no"
    t.string "client_name"
    t.string "client_email"
    t.string "client_telephone"
    t.string "client_street"
    t.string "client_city"
    t.string "client_region"
    t.string "client_postal_code"
    t.string "client_country"
    t.integer "supplier_id"
    t.string "supplier_registration_no"
    t.string "supplier_vat_no"
    t.string "supplier_name"
    t.string "supplier_email"
    t.string "supplier_telephone"
    t.string "supplier_street"
    t.string "supplier_city"
    t.string "supplier_region"
    t.string "supplier_postal_code"
    t.string "supplier_country"
    t.integer "project_id"
    t.integer "easy_invoice_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "author_id"
    t.integer "document_id"
    t.boolean "transferred_tax_liability"
    t.text "transferred_tax_liability_note", limit: 16777215
    t.string "locale"
    t.integer "easy_invoice_payment_method_id"
    t.string "invoice_name"
    t.boolean "easy_is_repeating"
    t.text "easy_repeat_settings", limit: 4294967295
    t.date "easy_next_start"
    t.boolean "is_template", default: false
    t.string "bic"
    t.integer "current_pdf_id"
    t.integer "easy_invoice_sequence_id"
    t.string "type", default: "EasyInvoice", null: false
    t.integer "easy_invoice_proforma_id"
    t.integer "easy_invoice_template_id"
    t.integer "easy_invoice_credit_note_id"
    t.string "easy_currency_code", limit: 3
    t.boolean "ordered_as_company"
    t.datetime "client_vat_validation_timestamp"
    t.decimal "subtotal_EUR", precision: 32, scale: 4
    t.decimal "total_EUR", precision: 32, scale: 4
    t.decimal "paid_amount_EUR", precision: 32, scale: 4
    t.decimal "vat_amount_EUR", precision: 32, scale: 4
    t.decimal "subtotal_USD", precision: 32, scale: 4
    t.decimal "total_USD", precision: 32, scale: 4
    t.decimal "paid_amount_USD", precision: 32, scale: 4
    t.decimal "vat_amount_USD", precision: 32, scale: 4
    t.string "easy_external_id"
    t.decimal "to_be_paid_amount", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "confirmed_paid_amount", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "confirmed_paid_amount_EUR", precision: 32, scale: 4
    t.decimal "confirmed_paid_amount_USD", precision: 32, scale: 4
    t.decimal "to_be_paid_amount_EUR", precision: 32, scale: 4
    t.decimal "to_be_paid_amount_USD", precision: 32, scale: 4
    t.decimal "subconfirmed_paid_amount", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "subconfirmed_paid_amount_EUR", precision: 32, scale: 4
    t.decimal "subconfirmed_paid_amount_USD", precision: 32, scale: 4
    t.index ["client_id"], name: "idx_einvoices_client"
    t.index ["is_template", "easy_invoice_template_id"], name: "idx_einvoices_3"
    t.index ["paid_at"], name: "idx_einvoices_2"
    t.index ["project_id"], name: "idx_einvoices_1"
    t.index ["supplier_id"], name: "idx_einvoices_supplier"
    t.index ["type"], name: "idx_einvoices_type"
  end

  create_table "easy_issue_allocators", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_id"
    t.string "allocator", null: false
  end

  create_table "easy_issue_timers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "pause", precision: 10, default: "0"
    t.datetime "paused_at"
    t.index ["issue_id", "user_id"], name: "index_easy_issue_timers_on_issue_id_and_user_id"
    t.index ["user_id", "issue_id"], name: "index_easy_issue_timers_on_user_id_and_issue_id"
  end

  create_table "easy_kanban_issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "issue_id"
    t.integer "phase", default: -1
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_easy_kanban_issues_on_issue_id"
    t.index ["project_id"], name: "index_easy_kanban_issues_on_project_id"
  end

  create_table "easy_knowledge_assigned_stories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "story_id", null: false
    t.integer "author_id", null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.date "required_reading_date"
    t.date "read_date"
  end

  create_table "easy_knowledge_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "author_id", null: false
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text "description", limit: 4294967295
  end

  create_table "easy_knowledge_stories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "author_id", null: false
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "storyviews", default: 0, null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text "description", limit: 4294967295
    t.integer "version"
  end

  create_table "easy_knowledge_story_categories", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "story_id", null: false
    t.integer "category_id", null: false
    t.index ["story_id", "category_id"], name: "idx_story_category", unique: true
  end

  create_table "easy_knowledge_story_references", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "referenced_by", null: false
    t.integer "referenced_to", null: false
    t.index ["referenced_by", "referenced_to"], name: "idx_kb_references", unique: true
  end

  create_table "easy_knowledge_story_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_knowledge_story_id"
    t.integer "version"
    t.string "name"
    t.integer "author_id"
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "storyviews", default: 0
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text "description", limit: 4294967295
  end

  create_table "easy_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "date", null: false
    t.integer "log_request_id"
    t.string "log_request_error"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_mail_campaign_mail_layouts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "html_head_style", limit: 4294967295
    t.text "html_body_header", limit: 4294967295
    t.text "html_body_footer", limit: 4294967295
  end

  create_table "easy_mail_campaign_sent_entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_mail_campaign_id", null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["easy_mail_campaign_id"], name: "idx_emcse_1"
    t.index ["entity_type", "entity_id"], name: "idx_emcse_2"
  end

  create_table "easy_mail_campaigns", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.integer "easy_mail_campaign_mail_layout_id", null: false
    t.string "type", null: false
    t.text "easy_query_filters", limit: 4294967295
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.integer "no_of_days", default: 0, null: false
    t.integer "send_hours", default: 12, null: false
    t.string "mail_sender", null: false
    t.string "mail_cc"
    t.string "mail_bcc"
    t.string "mail_subject", null: false
    t.text "mail_html_body", limit: 16777215, null: false
    t.datetime "last_executed"
    t.string "execute_as", null: false
    t.integer "execute_as_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "mail_reply_to"
    t.string "mail_to_source_type", default: "entity", null: false
    t.string "mail_to", null: false
    t.string "when_to_fire", default: "defined_time", null: false
    t.boolean "attach_file_to_email", default: false, null: false
    t.integer "repeat_interval", default: 0, null: false
    t.index ["project_id"], name: "idx_emc_1"
  end

  create_table "easy_meetings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.boolean "all_day", default: false, null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "mails", limit: 16777215
    t.integer "project_id"
    t.integer "easy_room_id"
    t.boolean "easy_is_repeating"
    t.text "easy_repeat_settings", limit: 4294967295
    t.date "easy_next_start"
    t.string "place_name"
    t.integer "easy_repeat_parent_id"
    t.string "uid", null: false
    t.integer "priority", default: 1, null: false
    t.integer "privacy", default: 0, null: false
    t.boolean "big_recurring", default: false
    t.boolean "easy_resource_dont_allocate", default: false
    t.integer "meeting_type", default: 0, null: false
    t.string "easy_zoom_meeting_uid"
    t.boolean "easy_zoom_pmi", default: false, null: false
    t.string "easy_zoom_access_token"
    t.boolean "emailed", default: false
    t.integer "email_notifications", default: 0
    t.boolean "zoom_update_required", default: false
    t.index ["author_id"], name: "index_easy_meetings_on_author_id"
    t.index ["easy_repeat_parent_id"], name: "index_easy_meetings_on_easy_repeat_parent_id"
    t.index ["easy_room_id"], name: "index_easy_meetings_on_easy_room_id"
  end

  create_table "easy_money_expected_expenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.decimal "price2", precision: 30, scale: 2, default: "0.0"
    t.decimal "vat", precision: 30, scale: 2, default: "0.0"
    t.date "spent_on"
    t.text "description", limit: 16777215
    t.string "name", null: false
    t.integer "version_id"
    t.string "easy_external_id"
    t.integer "tyear"
    t.integer "tmonth"
    t.integer "tweek"
    t.integer "tday"
    t.text "easy_repeat_settings", limit: 4294967295
    t.boolean "easy_is_repeating"
    t.date "easy_next_start"
    t.integer "project_id"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
    t.decimal "price2_EUR", precision: 32, scale: 4
    t.decimal "price2_USD", precision: 32, scale: 4
  end

  create_table "easy_money_expected_hours", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "hours", default: 0, null: false
    t.string "easy_external_id"
  end

  create_table "easy_money_expected_payroll_expenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.decimal "price", precision: 30, scale: 2, default: "0.0", null: false
    t.string "easy_external_id"
    t.integer "project_id"
    t.datetime "updated_at"
    t.string "easy_currency_code", limit: 3
    t.decimal "price_EUR", precision: 32, scale: 4
    t.decimal "price_USD", precision: 32, scale: 4
  end

  create_table "easy_money_expected_revenues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.decimal "price2", precision: 30, scale: 2, default: "0.0"
    t.decimal "vat", precision: 30, scale: 2, default: "0.0"
    t.date "spent_on"
    t.text "description", limit: 16777215
    t.string "name", null: false
    t.integer "version_id"
    t.string "easy_external_id"
    t.integer "tyear"
    t.integer "tmonth"
    t.integer "tweek"
    t.integer "tday"
    t.text "easy_repeat_settings", limit: 4294967295
    t.boolean "easy_is_repeating"
    t.date "easy_next_start"
    t.integer "project_id"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
    t.decimal "price2_EUR", precision: 32, scale: 4
    t.decimal "price2_USD", precision: 32, scale: 4
  end

  create_table "easy_money_other_expenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "spent_on"
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.decimal "price2", precision: 30, scale: 2, default: "0.0"
    t.decimal "vat", precision: 30, scale: 2, default: "0.0"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "version_id"
    t.string "easy_external_id"
    t.integer "tyear"
    t.integer "tmonth"
    t.integer "tweek"
    t.integer "tday"
    t.text "easy_repeat_settings", limit: 4294967295
    t.boolean "easy_is_repeating"
    t.date "easy_next_start"
    t.integer "project_id"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
    t.decimal "price2_EUR", precision: 32, scale: 4
    t.decimal "price2_USD", precision: 32, scale: 4
  end

  create_table "easy_money_other_revenues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "spent_on"
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.decimal "price2", precision: 30, scale: 2, default: "0.0"
    t.decimal "vat", precision: 30, scale: 2, default: "0.0"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "version_id"
    t.string "easy_external_id"
    t.integer "tyear"
    t.integer "tmonth"
    t.integer "tweek"
    t.integer "tday"
    t.text "easy_repeat_settings", limit: 4294967295
    t.boolean "easy_is_repeating"
    t.date "easy_next_start"
    t.integer "project_id"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
    t.decimal "price2_EUR", precision: 32, scale: 4
    t.decimal "price2_USD", precision: 32, scale: 4
  end

  create_table "easy_money_periodical_entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.integer "column_idx", default: 1, null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "project_id"
    t.integer "parent_id"
    t.integer "position"
    t.index ["type", "entity_type", "entity_id"], name: "idx_empe_2"
    t.index ["type", "project_id"], name: "idx_empe_3"
    t.index ["type"], name: "idx_empe_1"
  end

  create_table "easy_money_periodical_entity_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_money_periodical_entity_id", null: false
    t.integer "author_id", null: false
    t.date "period_date", null: false
    t.string "name"
    t.text "description", limit: 16777215
    t.decimal "price1", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "price2", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "vat", precision: 30, scale: 2, default: "0.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
    t.decimal "price2_EUR", precision: 32, scale: 4
    t.decimal "price2_USD", precision: 32, scale: 4
    t.index ["easy_money_periodical_entity_id"], name: "idx_empei_1"
  end

  create_table "easy_money_project_caches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.decimal "sum_of_expected_hours", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_expected_payroll_expenses", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_expected_expenses_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_expected_revenues_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_other_expenses_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_other_revenues_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_expected_expenses_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_expected_revenues_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_other_expenses_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_other_revenues_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_time_entries_expenses_internal", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_time_entries_expenses_external", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_estimated_hours", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_timeentries", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_expected_expenses_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_expected_revenues_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_revenues_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_expected_expenses_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_expected_revenues_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_revenues_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_expenses_price_1_internal", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_expenses_price_2_internal", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_expenses_price_1_external", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_other_expenses_price_2_external", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "expected_profit_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "expected_profit_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "other_profit_price_1_internal", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "other_profit_price_2_internal", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "other_profit_price_1_external", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "other_profit_price_2_external", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "average_hourly_rate_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "average_hourly_rate_price_2", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_travel_costs_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "sum_of_all_travel_expenses_price_1", precision: 60, scale: 2, default: "0.0", null: false
    t.decimal "profit_margin", precision: 60, scale: 2, default: "0.0", null: false
    t.string "easy_currency_code", limit: 3
    t.float "cost_ratio", default: 0.0, null: false
    t.index ["project_id", "easy_currency_code"], name: "index_empc_on_project_id_and_easy_currency_code", unique: true
  end

  create_table "easy_money_rate_priorities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "rate_type_id", null: false
    t.string "entity_type", null: false
    t.integer "position"
    t.index ["project_id", "rate_type_id"], name: "index_easy_money_rate_priorities_on_user_id_and_project_id"
  end

  create_table "easy_money_rate_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "status", default: 1, null: false
    t.boolean "is_default", default: false, null: false
    t.integer "position"
  end

  create_table "easy_money_rates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "rate_type_id", null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.decimal "unit_rate", precision: 30, scale: 2, default: "0.0", null: false
    t.date "valid_from"
    t.date "valid_to"
    t.datetime "updated_at"
    t.string "easy_currency_code", limit: 3
    t.index ["project_id", "rate_type_id", "entity_type", "entity_id"], name: "index_easy_money_rates_on_project_id_and_rate_type_and_entity"
  end

  create_table "easy_money_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "project_id"
    t.string "value"
    t.index ["name", "project_id"], name: "idx_settings_nameprojectid", unique: true
  end

  create_table "easy_money_time_entries_expenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "time_entry_id", null: false
    t.integer "rate_type_id", null: false
    t.decimal "price", precision: 30, scale: 2, default: "0.0"
    t.decimal "price_EUR", precision: 32, scale: 4
    t.decimal "price_USD", precision: 32, scale: 4
    t.index ["time_entry_id"], name: "idx_easy_money_time_entries_expenses_time_entry_id"
  end

  create_table "easy_money_travel_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "easy_external_id"
    t.date "spent_on"
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "project_id"
    t.integer "version_id"
    t.decimal "price_per_unit", precision: 30, scale: 2, default: "0.0"
    t.decimal "metric_units", precision: 30, scale: 2, default: "0.0"
    t.integer "tyear"
    t.integer "tmonth"
    t.integer "tweek"
    t.integer "tday"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
  end

  create_table "easy_money_travel_expenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "easy_external_id"
    t.date "spent_on"
    t.string "name", null: false
    t.text "description", limit: 16777215
    t.decimal "price1", precision: 30, scale: 2, default: "0.0"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "project_id"
    t.integer "version_id"
    t.integer "user_id"
    t.date "spent_on_to"
    t.decimal "price_per_day", precision: 30, scale: 2, default: "0.0"
    t.string "easy_currency_code", limit: 3
    t.decimal "price1_EUR", precision: 32, scale: 4
    t.decimal "price1_USD", precision: 32, scale: 4
  end

  create_table "easy_oauth2_access_grants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_oauth2_application_id", null: false
    t.bigint "user_id", null: false
    t.string "code"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "access_token_expires_at"
    t.string "state"
    t.string "referrer", limit: 2048
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_oauth2_application_id", "code"], name: "idx_eoag_1"
    t.index ["easy_oauth2_application_id"], name: "index_easy_oauth2_access_grants_on_easy_oauth2_application_id"
    t.index ["user_id"], name: "index_easy_oauth2_access_grants_on_user_id"
  end

  create_table "easy_oauth2_application_callbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_oauth2_application_id", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_oauth2_application_id"], name: "idx_eoac_1"
  end

  create_table "easy_oauth2_application_user_authorizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "easy_oauth2_application_id", null: false
    t.bigint "user_id", null: false
    t.string "code", null: false
    t.string "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_oauth2_application_id", "user_id"], name: "idx_eoaua_3"
    t.index ["easy_oauth2_application_id"], name: "idx_eoaua_1"
    t.index ["user_id"], name: "idx_eoaua_2"
  end

  create_table "easy_oauth2_applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "guid", limit: 36, null: false
    t.string "type", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.string "app_id"
    t.string "app_secret"
    t.string "app_url"
    t.text "settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id", "app_secret"], name: "idx_eop_1", unique: true
    t.index ["app_id"], name: "index_easy_oauth2_applications_on_app_id", unique: true
    t.index ["guid"], name: "index_easy_oauth2_applications_on_guid", unique: true
    t.index ["type"], name: "index_easy_oauth2_applications_on_type"
  end

  create_table "easy_oauth2_authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.text "provider_data", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "idx_eoa_1", unique: true
    t.index ["user_id"], name: "index_easy_oauth2_authentications_on_user_id"
  end

  create_table "easy_oauth2_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type"
    t.bigint "entity_id"
    t.string "key", null: false
    t.string "value", null: false
    t.datetime "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id"], name: "index_easy_oauth2_tokens_on_entity_type_and_entity_id"
    t.index ["valid_until"], name: "index_easy_oauth2_tokens_on_valid_until"
  end

  create_table "easy_oauth_access_grants", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "access_token", null: false
    t.string "refresh_token", null: false
    t.datetime "access_token_expires_at"
    t.integer "user_id", null: false
    t.integer "easy_oauth_client_id", null: false
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_oauth_authentications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", limit: 191, null: false
    t.string "uuid", limit: 191, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uuid"], name: "index_easy_oauth_authentications_on_provider_and_uuid", unique: true
  end

  create_table "easy_oauth_clients", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "app_id", limit: 191, null: false
    t.string "app_secret", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_easy_oauth_clients_on_app_id", unique: true
  end

  create_table "easy_onboarding_link_easy_user_type_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_onboarding_link_id", null: false
    t.integer "easy_user_type_id", null: false
    t.integer "position"
  end

  create_table "easy_onboarding_links", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "label"
    t.string "link_url"
    t.text "settings"
  end

  create_table "easy_org_chart_nodes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "parent_id"
    t.integer "root_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_easy_org_chart_nodes_on_lft"
    t.index ["user_id"], name: "index_easy_org_chart_nodes_on_user_id"
  end

  create_table "easy_page_available_modules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_pages_id"
    t.integer "easy_page_modules_id"
    t.index ["easy_pages_id", "easy_page_modules_id"], name: "idx_av_modules", unique: true
  end

  create_table "easy_page_available_zones", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_pages_id"
    t.integer "easy_page_zones_id"
    t.integer "position"
    t.index ["easy_pages_id", "easy_page_zones_id"], name: "idx_av_zones", unique: true
  end

  create_table "easy_page_modules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type"
  end

  create_table "easy_page_permissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_page_id"
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "permission_type", default: 0, null: false
    t.index ["entity_type", "entity_id"], name: "index_easy_page_permissions_on_entity_type_and_entity_id"
  end

  create_table "easy_page_template_modules", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_page_templates_id", null: false
    t.integer "easy_page_available_zones_id", null: false
    t.integer "easy_page_available_modules_id", null: false
    t.string "uuid", null: false
    t.integer "entity_id"
    t.integer "position"
    t.text "settings", limit: 4294967295
    t.integer "tab_id"
    t.integer "tab", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_page_templates_id", "easy_page_available_zones_id", "entity_id"], name: "idx_easy_page_template_modules_3"
    t.index ["easy_page_templates_id", "easy_page_available_zones_id"], name: "idx_easy_page_template_modules_1"
    t.index ["uuid"], name: "idx_easy_page_template_modules_2", unique: true
  end

  create_table "easy_page_template_tabs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "page_template_id", null: false
    t.integer "position"
    t.string "name", null: false
    t.integer "entity_id"
    t.text "settings", limit: 4294967295
    t.boolean "mobile_default", default: false
    t.index ["page_template_id", "entity_id", "position"], name: "idx_ep_template_tabs", unique: true
  end

  create_table "easy_page_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_pages_id"
    t.string "template_name", null: false
    t.string "description"
    t.boolean "is_default", default: false, null: false
    t.integer "position"
  end

  create_table "easy_page_user_tabs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "page_id", null: false
    t.integer "user_id"
    t.integer "position"
    t.string "name", null: false
    t.integer "entity_id"
    t.text "settings", limit: 4294967295
    t.boolean "mobile_default", default: false
    t.index ["entity_id"], name: "idx_eput_entity_id"
    t.index ["page_id"], name: "idx_eput_page_id"
    t.index ["position"], name: "idx_eput_position"
    t.index ["user_id", "page_id", "entity_id", "position"], name: "idx_ep_user_tabs", unique: true
    t.index ["user_id"], name: "idx_eput_user_id"
  end

  create_table "easy_page_zone_modules", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_pages_id", null: false
    t.integer "easy_page_available_zones_id", null: false
    t.integer "easy_page_available_modules_id", null: false
    t.integer "user_id"
    t.string "uuid", null: false
    t.integer "entity_id"
    t.integer "position"
    t.text "settings", limit: 4294967295
    t.integer "tab_id"
    t.integer "tab", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_pages_id", "easy_page_available_zones_id", "user_id", "entity_id", "tab"], name: "idx_easy_page_zone_modules_1"
    t.index ["uuid"], name: "idx_easy_page_zone_modules_2", unique: true
  end

  create_table "easy_page_zones", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "zone_name", null: false
  end

  create_table "easy_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "page_name", null: false
    t.string "layout_path", null: false
    t.string "identifier"
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "user_id"
    t.string "user_defined_name"
    t.text "description", limit: 16777215
    t.string "page_scope"
    t.boolean "has_template", default: false, null: false
    t.boolean "is_user_defined", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "version", default: 0, null: false
    t.boolean "strict_permissions", default: false
    t.boolean "strict_show_permissions", default: false
  end

  create_table "easy_payment_entity_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id"
    t.string "entity_type"
    t.integer "easy_payment_id"
    t.index ["easy_payment_id", "entity_type", "entity_id"], name: "index_by_payment_entity"
    t.index ["easy_payment_id"], name: "payment_id_assignments"
    t.index ["entity_type", "entity_id"], name: "payment_assignments_entity"
  end

  create_table "easy_payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "number"
    t.string "bank_account"
    t.decimal "amount", precision: 30, scale: 2, default: "0.0", null: false
    t.string "easy_currency_code", limit: 3
    t.date "paid_at"
    t.string "customer_name"
    t.string "customer_country"
    t.text "message"
    t.boolean "is_multiple", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "subamount", precision: 30, scale: 2, default: "0.0", null: false
    t.decimal "amount_EUR", precision: 32, scale: 4
    t.decimal "amount_USD", precision: 32, scale: 4
    t.decimal "subamount_EUR", precision: 32, scale: 4
    t.decimal "subamount_USD", precision: 32, scale: 4
    t.index ["number"], name: "index_easy_payments_on_number"
    t.index ["paid_at"], name: "index_easy_payments_on_paid_at"
    t.index ["project_id"], name: "index_easy_payments_on_project_id"
  end

  create_table "easy_pdf_themes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "header_color_r"
    t.integer "header_color_g"
    t.integer "header_color_b"
    t.integer "header_font_color_r"
    t.integer "header_font_color_g"
    t.integer "header_font_color_b"
    t.boolean "is_default", default: false, null: false
    t.boolean "easy_system_flag", default: false, null: false
  end

  create_table "easy_permissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.string "name", null: false
    t.integer "entity_id", null: false
    t.text "user_list", limit: 16777215
    t.text "permissions", limit: 16777215
    t.text "role_list", limit: 16777215
  end

  create_table "easy_personal_finance_references", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "template_id", null: false
    t.integer "entry_id", null: false
    t.index ["template_id", "entry_id"], name: "easy_personal_finance_references_template_entry"
  end

  create_table "easy_personal_finances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.date "spent_on"
    t.text "description", limit: 16777215
    t.integer "user_id"
    t.integer "author_id"
    t.integer "payment_method_id"
    t.string "currency"
    t.boolean "is_template", default: false
    t.text "easy_repeat_settings", limit: 4294967295
    t.boolean "easy_is_repeating"
    t.date "easy_next_start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_price_book_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_price_book_id"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.string "unit", null: false
    t.decimal "price", precision: 30, scale: 2, default: "0.0", null: false
    t.string "currency", default: "EUR", null: false
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "easy_printable_template_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_printable_template_id", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "page_text", limit: 4294967295, null: false
    t.index ["easy_printable_template_id"], name: "idx_eptp_template_id"
  end

  create_table "easy_printable_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 2048, null: false
    t.integer "project_id"
    t.integer "author_id", null: false
    t.boolean "private", default: false, null: false
    t.string "pages_orientation", null: false
    t.string "pages_size", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "category", default: "custom", null: false
    t.string "internal_name"
    t.string "description"
    t.index ["category"], name: "idx_ept_category"
    t.index ["internal_name"], name: "idx_ept_internal_name"
  end

  create_table "easy_queries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "name", default: "", null: false
    t.text "filters", limit: 4294967295
    t.integer "user_id", default: 0, null: false
    t.integer "visibility", default: 0
    t.text "column_names", limit: 4294967295
    t.text "sort_criteria", limit: 4294967295
    t.string "group_by"
    t.string "type"
    t.text "settings", limit: 4294967295
    t.boolean "show_sum_row", default: false
    t.boolean "groups_opened", default: false
    t.boolean "is_tagged", default: false, null: false
    t.boolean "is_for_subprojects"
    t.text "chart_settings", limit: 4294967295
    t.string "calculation_formula"
    t.boolean "show_avatars", default: true
    t.text "period_settings", limit: 4294967295
    t.text "custom_formatting", limit: 4294967295
    t.string "easy_currency_code", limit: 3
    t.string "outputs", default: "---\n- list\n"
    t.boolean "daily_snapshot", default: false
    t.string "query_string"
    t.index ["id", "type"], name: "idx_easy_queries_1"
    t.index ["project_id"], name: "idx_easy_queries_project_id"
    t.index ["user_id"], name: "idx_easy_queries_user_id"
  end

  create_table "easy_queries_easy_user_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_query_id", null: false
    t.integer "easy_user_type_id", null: false
    t.index ["easy_query_id", "easy_user_type_id"], name: "easy_queries_user_types_ids"
  end

  create_table "easy_queries_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_query_id", null: false
    t.integer "role_id", null: false
    t.index ["easy_query_id", "role_id"], name: "easy_queries_roles_ids", unique: true
  end

  create_table "easy_query_snapshot_data", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_query_snapshot_id"
    t.date "date", null: false
    t.float "value1"
    t.float "value2"
    t.float "value3"
    t.float "value4"
    t.float "value5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_query_snapshot_id", "date"], name: "idx_eqsd_1"
  end

  create_table "easy_query_snapshots", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_query_id"
    t.string "epzm_uuid", limit: 36
    t.string "execute_as", default: "author", null: false
    t.integer "execute_as_user_id"
    t.text "period_options", limit: 4294967295
    t.text "settings", limit: 16777215
    t.datetime "last_executed"
    t.datetime "nextrun_at"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_query_id"], name: "index_easy_query_snapshots_on_easy_query_id"
    t.index ["epzm_uuid"], name: "index_easy_query_snapshots_on_epzm_uuid"
    t.index ["nextrun_at"], name: "index_easy_query_snapshots_on_nextrun_at"
  end

  create_table "easy_rake_task_info_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_rake_task_info_id", null: false
    t.string "type", null: false
    t.integer "status", default: 0, null: false
    t.text "detail", limit: 16777215
    t.string "entity_type"
    t.integer "entity_id"
    t.integer "reference_id"
    t.string "reference_type"
    t.index ["easy_rake_task_info_id"], name: "index_ertid_on_info_id"
    t.index ["status"], name: "index_ertid_on_status"
  end

  create_table "easy_rake_task_infos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_rake_task_id", null: false
    t.integer "status", null: false
    t.datetime "started_at", null: false
    t.datetime "finished_at"
    t.text "note", limit: 16777215
    t.text "options", limit: 4294967295
    t.string "method_to_execute"
    t.index ["easy_rake_task_id", "status"], name: "index_erti_on_task_id_status"
  end

  create_table "easy_rake_tasks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type", limit: 2048, null: false
    t.boolean "active", default: true, null: false
    t.text "settings", limit: 16777215
    t.string "period", null: false
    t.integer "interval", null: false
    t.datetime "next_run_at", null: false
    t.integer "builtin", default: 0, null: false
    t.string "failure_mail"
    t.integer "project_id"
    t.integer "last_duration", default: 0, null: false
    t.integer "average_duration", default: 0, null: false
    t.datetime "blocked_at"
  end

  create_table "easy_report_issue_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_id", null: false
    t.integer "status_time_0"
    t.integer "status_count_0"
    t.integer "status_time_1"
    t.integer "status_count_1"
    t.integer "status_time_2"
    t.integer "status_count_2"
    t.integer "status_time_3"
    t.integer "status_count_3"
    t.integer "status_time_4"
    t.integer "status_count_4"
    t.integer "status_time_5"
    t.integer "status_count_5"
    t.integer "status_time_6"
    t.integer "status_count_6"
    t.integer "status_time_7"
    t.integer "status_count_7"
    t.integer "status_time_8"
    t.integer "status_count_8"
    t.integer "status_time_9"
    t.integer "status_count_9"
    t.integer "status_time_10"
    t.integer "status_count_10"
    t.integer "status_time_11"
    t.integer "status_count_11"
    t.integer "status_time_12"
    t.integer "status_count_12"
    t.integer "status_time_13"
    t.integer "status_count_13"
    t.integer "status_time_14"
    t.integer "status_count_14"
    t.integer "status_time_15"
    t.integer "status_count_15"
    t.integer "status_time_16"
    t.integer "status_count_16"
    t.integer "status_time_17"
    t.integer "status_count_17"
    t.integer "status_time_18"
    t.integer "status_count_18"
    t.integer "status_time_19"
    t.integer "status_count_19"
    t.integer "status_time_20"
    t.integer "status_count_20"
    t.integer "status_time_21"
    t.integer "status_count_21"
    t.integer "status_time_22"
    t.integer "status_count_22"
    t.integer "status_time_23"
    t.integer "status_count_23"
    t.integer "status_time_24"
    t.integer "status_count_24"
    t.integer "status_time_25"
    t.integer "status_count_25"
    t.integer "status_time_26"
    t.integer "status_count_26"
    t.integer "status_time_27"
    t.integer "status_count_27"
    t.integer "status_time_28"
    t.integer "status_count_28"
    t.integer "status_time_29"
    t.integer "status_count_29"
    t.index ["issue_id"], name: "idx_eris_1", unique: true
  end

  create_table "easy_report_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "last_run"
    t.text "settings", limit: 4294967295
    t.index ["name"], name: "idx_ers_1"
  end

  create_table "easy_resource_availabilities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "easy_page_zone_module_uuid", null: false
    t.text "description", limit: 16777215
    t.integer "author_id", null: false
    t.date "date", null: false
    t.integer "hour", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_id"], name: "idx_era_author_id"
    t.index ["easy_page_zone_module_uuid"], name: "idx_era_easy_page_zone_module_uuid"
  end

  create_table "easy_rois", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "date", null: false
    t.string "country", limit: 3
    t.string "product"
    t.decimal "costs", precision: 10, scale: 2
    t.decimal "revenues", precision: 10, scale: 2
    t.index ["country"], name: "index_easy_rois_on_country"
    t.index ["date"], name: "index_easy_rois_on_date"
    t.index ["product"], name: "index_easy_rois_on_product"
  end

  create_table "easy_role_tracker_restrictions", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "tracker_id"
    t.index ["role_id", "tracker_id"], name: "index_easy_role_tracker_restrictions_on_role_id_and_tracker_id", unique: true
  end

  create_table "easy_rooms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_saml_service_providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.text "settings", limit: 16777215
    t.text "metadata", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_easy_saml_service_providers_on_identifier"
  end

  create_table "easy_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "value", limit: 16777215
    t.integer "project_id"
    t.index ["name", "project_id"], name: "index_easy_settings_on_name_and_project_id", unique: true
    t.index ["project_id"], name: "index_easy_settings_on_project_id"
  end

  create_table "easy_short_url_accesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_short_url_id"
    t.integer "user_id"
    t.string "ip", limit: 128
    t.integer "count", default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_short_urls", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "shortcut", null: false
    t.string "source_url", limit: 4096, null: false
    t.datetime "valid_to"
    t.string "entity_type"
    t.integer "entity_id"
    t.boolean "allow_external", default: false, null: false
    t.index ["entity_type", "entity_id"], name: "index_easy_short_urls_on_entity_type_and_entity_id"
    t.index ["shortcut"], name: "index_easy_short_urls_on_shortcut", unique: true
  end

  create_table "easy_sla_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "occurence_time"
    t.integer "issue_id"
    t.integer "user_id"
    t.datetime "sla_response"
    t.datetime "sla_resolve"
    t.float "first_response"
    t.float "sla_response_fulfilment"
    t.float "sla_resolve_fulfilment"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_response"], name: "index_easy_sla_events_on_first_response"
    t.index ["issue_id"], name: "index_easy_sla_events_on_issue_id"
    t.index ["occurence_time"], name: "index_easy_sla_events_on_occurence_time"
    t.index ["project_id"], name: "index_easy_sla_events_on_project_id"
    t.index ["sla_resolve"], name: "index_easy_sla_events_on_sla_resolve"
    t.index ["sla_response"], name: "index_easy_sla_events_on_sla_response"
    t.index ["user_id"], name: "index_easy_sla_events_on_user_id"
  end

  create_table "easy_sliding_panels_locations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "zone"
    t.string "name"
    t.integer "user_id"
    t.integer "position"
  end

  create_table "easy_social_portal_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", limit: 4294967295
    t.boolean "all_day", default: false, null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "easy_is_repeating"
    t.text "easy_repeat_settings", limit: 4294967295
    t.date "easy_next_start"
    t.index ["author_id"], name: "index_easy_social_portal_events_on_author_id"
  end

  create_table "easy_social_portal_posts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "description", limit: 4294967295, null: false
    t.integer "author_id"
    t.integer "easy_social_portal_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "comments_count", default: 0, null: false
    t.index ["author_id"], name: "index_easy_social_portal_posts_on_author_id"
    t.index ["easy_social_portal_event_id"], name: "index_easy_social_portal_posts_on_easy_social_portal_event_id"
  end

  create_table "easy_sprints", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "due_date"
    t.integer "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "capacity", default: 0, null: false
    t.integer "version_id"
    t.boolean "cross_project", default: false, null: false
    t.integer "display_closed_tasks_in_last_n_days"
    t.text "goal", limit: 4294967295
    t.boolean "closed", default: false
    t.index ["project_id"], name: "index_easy_sprints_on_project_id"
  end

  create_table "easy_sync_mappings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "category"
    t.integer "local_id"
    t.string "local_name"
    t.integer "remote_id"
    t.string "remote_name"
    t.string "value_type", limit: 25
  end

  create_table "easy_sync_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id", null: false
    t.string "entity_type", null: false
    t.string "direction", default: "import", null: false
    t.string "remote_name", null: false
    t.string "remote_id", null: false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "easy_tenants", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "subdomain", null: false
    t.string "database_name", null: false
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.integer "deploy_entity_id"
    t.string "deploy_entity_type"
    t.integer "status", default: 0, null: false
    t.string "language", limit: 10, default: "en"
    t.string "company"
    t.string "dns_a_record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.text "settings", limit: 16777215
    t.index ["parent_id"], name: "index_easy_tenants_on_parent_id"
    t.index ["subdomain"], name: "index_easy_tenants_on_subdomain"
  end

  create_table "easy_textile_migrators", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.string "entity_column", null: false
    t.string "source_formatting", null: false
    t.text "source_text", limit: 4294967295, null: false
    t.text "target_text", limit: 4294967295, null: false
    t.index ["entity_type", "entity_id"], name: "index_easy_textile_migrators_on_entity_type_and_entity_id"
  end

  create_table "easy_theme_design_entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_theme_design_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["entity_id", "entity_type"], name: "design_entity_idx"
  end

  create_table "easy_theme_designs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "description", limit: 16777215
    t.integer "position"
    t.string "primary_color", null: false
    t.string "secondary_color", null: false
    t.text "css", limit: 4294967295
    t.text "extra_css_properties", limit: 4294967295
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean "in_use", default: false, null: false
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "internal_name"
    t.text "advanced_options", limit: 16777215
    t.string "background_image_file_name"
    t.string "background_image_content_type"
    t.integer "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.integer "version", default: 0, null: false
  end

  create_table "easy_timesheets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "period"
    t.integer "user_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "locked", default: false, null: false
    t.integer "locked_by_id"
    t.datetime "locked_at"
    t.integer "unlocked_by_id"
    t.datetime "unlocked_at"
    t.text "lock_description", limit: 16777215
    t.index ["user_id", "start_date", "end_date"], name: "idx_et_2"
    t.index ["user_id"], name: "idx_et_1"
  end

  create_table "easy_to_do_list_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_to_do_list_id", null: false
    t.string "name", null: false
    t.boolean "is_done", default: false, null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "entity_id"
    t.string "entity_type"
  end

  create_table "easy_to_do_lists", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "easy_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "entity_id"
    t.string "entity_type"
    t.string "entity_column", null: false
    t.string "lang", default: "en", null: false
    t.text "value", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["entity_id", "entity_type", "entity_column", "lang"], name: "easy_translations_entity_lang", unique: true
  end

  create_table "easy_twofa_remembers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_twofa_user_scheme_id", null: false
    t.date "expired_at", null: false
    t.text "device", limit: 16777215, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["easy_twofa_user_scheme_id"], name: "index_easy_twofa_remembers_on_easy_twofa_user_scheme_id"
  end

  create_table "easy_twofa_user_schemes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "activated", default: false, null: false
    t.string "scheme_key", null: false
    t.text "settings", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_easy_twofa_user_schemes_on_user_id"
    t.index ["user_id"], name: "unique_index_easy_twofa_user_schemes_user_id", unique: true
  end

  create_table "easy_user_read_entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.datetime "read_on", null: false
    t.index ["entity_type", "entity_id"], name: "idx_easy_read_user_entities_2"
    t.index ["user_id", "entity_type", "entity_id"], name: "idx_easy_read_user_entities_1", unique: true
  end

  create_table "easy_user_superiors_inferiors", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "superior_id"
    t.integer "inferior_id"
    t.index ["superior_id", "inferior_id"], name: "easy_user_superiors_inferiors_sup_id_inf_id", unique: true
  end

  create_table "easy_user_targets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "target", precision: 30, scale: 2, default: "0.0", null: false
    t.string "currency"
    t.date "valid_from"
    t.date "valid_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "target_EUR", precision: 32, scale: 4
    t.decimal "target_USD", precision: 32, scale: 4
  end

  create_table "easy_user_time_calendar_exceptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.date "exception_date", null: false
    t.float "working_hours", null: false
    t.index ["calendar_id"], name: "index_easy_user_time_calendar_exceptions_on_calendar_id"
  end

  create_table "easy_user_time_calendar_holidays", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.string "name", default: "", null: false
    t.date "holiday_date", null: false
    t.boolean "is_repeating", default: true, null: false
    t.text "ical_uid", limit: 16777215
    t.index ["calendar_id", "ical_uid"], name: "index_ical_uid", unique: true, length: { ical_uid: 255 }
    t.index ["calendar_id"], name: "index_easy_user_time_calendar_holidays_on_calendar_id"
  end

  create_table "easy_user_time_calendars", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id"
    t.integer "parent_id"
    t.string "type", limit: 2048, null: false
    t.float "default_working_hours", null: false
    t.integer "first_day_of_week", default: 1, null: false
    t.boolean "builtin", default: false, null: false
    t.boolean "is_default", default: false, null: false
    t.integer "position"
    t.datetime "time_from"
    t.datetime "time_to"
    t.text "working_week_days", limit: 16777215
    t.text "ical_url", limit: 16777215
    t.datetime "created_at", default: "2018-07-06 18:32:17"
    t.datetime "updated_at", default: "2018-07-06 18:32:17"
    t.index ["parent_id"], name: "index_easy_user_time_calendars_on_parent_id"
    t.index ["position"], name: "index_easy_user_time_calendars_on_position"
    t.index ["user_id"], name: "index_easy_user_time_calendars_on_user_id"
  end

  create_table "easy_user_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position"
    t.boolean "is_default", default: false, null: false
    t.boolean "internal", default: true, null: false
    t.text "settings", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_in_meeting_calendar", default: true, null: false
    t.integer "easy_page_template_id"
    t.text "description", limit: 16777215
    t.integer "role_id"
    t.boolean "partner", default: false, null: false
    t.integer "builtin_role_id"
  end

  create_table "easy_user_types_easy_user_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_user_type_id"
    t.integer "easy_user_visible_type_id"
    t.index ["easy_user_type_id", "easy_user_visible_type_id"], name: "idx_easy_user_vt_euvtic", unique: true
    t.index ["easy_user_type_id"], name: "idx_easy_user_vt_euti"
    t.index ["easy_user_visible_type_id"], name: "idx_easy_user_vt_euvti"
  end

  create_table "easy_web_hooks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "entity_type", null: false
    t.string "action", null: false
    t.string "url", null: false
    t.string "entity_data_type", default: "json", null: false
    t.integer "project_id"
    t.integer "author_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "api_includes"
    t.index ["entity_type", "status", "action", "project_id"], name: "index_entity_type_status_action_project_id"
    t.index ["entity_type", "status", "action"], name: "index_entity_type_status_action"
    t.index ["entity_type"], name: "index_easy_web_hooks_on_entity_type"
    t.index ["status", "action", "project_id"], name: "index_status_action_project_id"
    t.index ["status", "action"], name: "index_status_action"
    t.index ["status"], name: "index_easy_web_hooks_on_status"
  end

  create_table "easy_webdav_locks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "scope", limit: 10
    t.string "type", limit: 10
    t.string "owner", limit: 50
    t.string "token"
    t.string "path"
    t.datetime "expired_at"
  end

  create_table "email_addresses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "address", null: false
    t.boolean "is_default", default: false, null: false
    t.boolean "notify", default: true, null: false
    t.datetime "created_on", null: false
    t.datetime "updated_on", null: false
    t.index ["user_id"], name: "index_email_addresses_on_user_id"
  end

  create_table "enabled_modules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "name", null: false
    t.index ["project_id"], name: "enabled_modules_project_id"
  end

  create_table "enumerations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.integer "position"
    t.boolean "is_default", default: false, null: false
    t.string "type"
    t.boolean "active", default: true, null: false
    t.integer "project_id"
    t.integer "parent_id"
    t.string "position_name", limit: 30
    t.string "easy_color_scheme"
    t.string "internal_name"
    t.string "easy_external_id"
    t.boolean "allow_time_entry_zero_hours", default: false, null: false
    t.boolean "allow_time_entry_negative_hours", default: false, null: false
    t.string "easy_icon"
    t.integer "status"
    t.string "description"
    t.index ["id", "type"], name: "index_enumerations_on_id_and_type"
    t.index ["internal_name"], name: "index_enumerations_on_internal_name", unique: true
    t.index ["project_id"], name: "index_enumerations_on_project_id"
  end

  create_table "groups_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.index ["group_id", "user_id"], name: "groups_users_ids", unique: true
  end

  create_table "import_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "import_id", null: false
    t.integer "position", null: false
    t.integer "obj_id"
    t.text "message", limit: 16777215
    t.string "unique_id"
    t.index ["import_id", "unique_id"], name: "index_import_items_on_import_id_and_unique_id"
  end

  create_table "imports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type"
    t.integer "user_id", null: false
    t.string "filename"
    t.text "settings", limit: 16777215
    t.integer "total_items"
    t.boolean "finished", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", default: 0, null: false
    t.string "name", limit: 60, default: "", null: false
    t.integer "assigned_to_id"
    t.integer "parent_id"
    t.integer "lft", default: 0, null: false
    t.integer "rgt", default: 0, null: false
    t.index ["assigned_to_id"], name: "index_issue_categories_on_assigned_to_id"
    t.index ["project_id"], name: "issue_categories_project_id"
  end

  create_table "issue_easy_sprint_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_id"
    t.integer "easy_sprint_id"
    t.integer "relation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "relation_position"
    t.integer "position"
    t.index ["easy_sprint_id"], name: "index_issue_easy_sprint_relations_on_easy_sprint_id"
    t.index ["issue_id"], name: "index_issue_easy_sprint_relations_on_issue_id"
  end

  create_table "issue_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_from_id", null: false
    t.integer "issue_to_id", null: false
    t.string "relation_type", default: "", null: false
    t.integer "delay"
    t.index ["issue_from_id", "issue_to_id"], name: "index_issue_relations_on_issue_from_id_and_issue_to_id", unique: true
    t.index ["issue_from_id"], name: "index_issue_relations_on_issue_from_id"
    t.index ["issue_to_id"], name: "index_issue_relations_on_issue_to_id"
  end

  create_table "issue_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.text "description", limit: 16777215
    t.boolean "is_closed", default: false, null: false
    t.integer "position"
    t.integer "default_done_ratio"
    t.string "easy_color_scheme"
    t.string "easy_external_id"
    t.index ["is_closed"], name: "index_issue_statuses_on_is_closed"
    t.index ["position"], name: "index_issue_statuses_on_position"
  end

  create_table "issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "tracker_id", null: false
    t.integer "project_id", null: false
    t.string "subject", default: "", null: false
    t.text "description", limit: 4294967295
    t.date "due_date"
    t.integer "category_id"
    t.integer "status_id", null: false
    t.integer "assigned_to_id"
    t.integer "priority_id", null: false
    t.integer "fixed_version_id"
    t.integer "author_id", null: false
    t.integer "lock_version", default: 0, null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.date "start_date"
    t.integer "done_ratio", default: 0, null: false
    t.float "estimated_hours"
    t.integer "parent_id"
    t.integer "root_id"
    t.integer "lft"
    t.integer "rgt"
    t.boolean "is_private", default: false, null: false
    t.datetime "closed_on"
    t.boolean "easy_is_easy_template", default: false
    t.integer "activity_id"
    t.integer "easy_level"
    t.string "easy_external_id"
    t.datetime "easy_due_date_time"
    t.boolean "easy_is_repeating", default: false
    t.text "easy_repeat_settings", limit: 16777215
    t.date "easy_next_start"
    t.datetime "easy_start_date_time"
    t.integer "easy_closed_by_id"
    t.datetime "easy_status_updated_on"
    t.integer "easy_last_updated_by_id"
    t.text "easy_email_to", limit: 16777215
    t.text "easy_email_cc", limit: 16777215
    t.integer "easy_sprint_id"
    t.integer "easy_story_points", default: 0
    t.integer "easy_duration"
    t.index ["assigned_to_id"], name: "index_issues_on_assigned_to_id"
    t.index ["author_id"], name: "index_issues_on_author_id"
    t.index ["category_id"], name: "index_issues_on_category_id"
    t.index ["created_on"], name: "index_issues_on_created_on"
    t.index ["easy_sprint_id"], name: "index_issues_on_easy_sprint_id"
    t.index ["fixed_version_id"], name: "index_issues_on_fixed_version_id"
    t.index ["lft"], name: "idx_issues_tree_1"
    t.index ["parent_id"], name: "index_issues_on_parent_id"
    t.index ["priority_id"], name: "index_issues_on_priority_id"
    t.index ["project_id"], name: "issues_project_id"
    t.index ["root_id", "lft", "rgt"], name: "index_issues_on_root_id_and_lft_and_rgt"
    t.index ["status_id"], name: "index_issues_on_status_id"
    t.index ["tracker_id"], name: "index_issues_on_tracker_id"
    t.index ["updated_on"], name: "index_issues_on_updated_on"
  end

  create_table "journal_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "journal_id", default: 0, null: false
    t.string "property", limit: 30, default: "", null: false
    t.string "prop_key", default: "", null: false
    t.text "old_value", limit: 4294967295
    t.text "value", limit: 4294967295
    t.index ["journal_id"], name: "journal_details_journal_id"
  end

  create_table "journals", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "journalized_id", default: 0, null: false
    t.string "journalized_type", limit: 60, default: "", null: false
    t.integer "user_id", default: 0, null: false
    t.text "notes", limit: 4294967295
    t.datetime "created_on", null: false
    t.boolean "private_notes", default: false, null: false
    t.string "easy_type"
    t.boolean "is_system", default: false
    t.index ["created_on"], name: "index_journals_on_created_on"
    t.index ["easy_type"], name: "index_journals_on_easy_type"
    t.index ["journalized_id", "journalized_type"], name: "journals_journalized_id"
    t.index ["journalized_id"], name: "index_journals_on_journalized_id"
    t.index ["user_id"], name: "index_journals_on_user_id"
  end

  create_table "mautic_connections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "type"
    t.string "url"
    t.string "client_id"
    t.string "secret"
    t.string "token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "role_id", null: false
    t.integer "inherited_from"
    t.index ["inherited_from"], name: "index_member_roles_on_inherited_from"
    t.index ["member_id"], name: "index_member_roles_on_member_id"
    t.index ["role_id"], name: "index_member_roles_on_role_id"
  end

  create_table "members", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false
    t.integer "project_id", default: 0, null: false
    t.datetime "created_on"
    t.boolean "mail_notification", default: false, null: false
    t.string "easy_external_id"
    t.boolean "dmsf_mail_notification"
    t.text "dmsf_title_format", limit: 255
    t.boolean "dmsf_fast_links", default: false, null: false
    t.index ["project_id"], name: "index_members_on_project_id"
    t.index ["user_id", "project_id"], name: "index_members_on_user_id_and_project_id", unique: true
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "board_id", null: false
    t.integer "parent_id"
    t.string "subject", default: "", null: false
    t.text "content", limit: 16777215
    t.integer "author_id"
    t.integer "replies_count", default: 0, null: false
    t.integer "last_reply_id"
    t.datetime "created_on", null: false
    t.datetime "updated_on", null: false
    t.boolean "locked", default: false
    t.integer "sticky", default: 0
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["board_id"], name: "messages_board_id"
    t.index ["created_on"], name: "index_messages_on_created_on"
    t.index ["last_reply_id"], name: "index_messages_on_last_reply_id"
    t.index ["parent_id"], name: "messages_parent_id"
  end

  create_table "news", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "title", limit: 60, default: "", null: false
    t.string "summary", default: ""
    t.text "description", limit: 4294967295
    t.integer "author_id", default: 0, null: false
    t.datetime "created_on"
    t.integer "comments_count", default: 0, null: false
    t.boolean "spinned", default: false, null: false
    t.integer "easy_external_id"
    t.index ["author_id"], name: "index_news_on_author_id"
    t.index ["created_on"], name: "index_news_on_created_on"
    t.index ["project_id"], name: "news_project_id"
  end

  create_table "old_passwords", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "hashed_password", limit: 40, default: "", null: false
    t.string "salt", limit: 64, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_id_authentication_associations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string "handle"
    t.string "assoc_type"
    t.binary "server_url"
    t.binary "secret"
  end

  create_table "open_id_authentication_nonces", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "timestamp", null: false
    t.string "server_url"
    t.string "salt", null: false
  end

  create_table "projectqueries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "filters", limit: 16777215
    t.integer "user_id", default: 0, null: false
    t.boolean "is_public", default: false, null: false
    t.text "column_names", limit: 16777215
    t.text "sort_criteria", limit: 16777215
    t.string "group_by"
  end

  create_table "projects", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "description", limit: 4294967295
    t.string "homepage", default: ""
    t.boolean "is_public", default: true, null: false
    t.integer "parent_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "identifier"
    t.integer "status", default: 1, null: false
    t.integer "lft"
    t.integer "rgt"
    t.boolean "inherit_members", default: false, null: false
    t.integer "default_version_id"
    t.integer "default_assigned_to_id"
    t.boolean "easy_is_easy_template", default: false
    t.date "easy_due_date"
    t.integer "author_id"
    t.date "easy_start_date"
    t.integer "easy_level"
    t.string "easy_external_id"
    t.integer "easy_currency_id"
    t.string "easy_currency_code", limit: 3
    t.integer "easy_priority_id"
    t.boolean "easy_has_custom_menu", default: false, null: false
    t.integer "easy_baseline_for_id"
    t.datetime "destroy_at"
    t.text "dmsf_description"
    t.boolean "dmsf_notification", default: false
    t.integer "dmsf_act_as_attachable", default: 1, null: false
    t.index ["easy_baseline_for_id"], name: "index_projects_on_easy_baseline_for_id"
    t.index ["easy_is_easy_template"], name: "index_projects_on_easy_is_easy_template"
    t.index ["lft", "rgt"], name: "idx_projects_tree_1"
    t.index ["lft"], name: "idx_projects_tree_2"
    t.index ["lft"], name: "index_projects_on_lft"
    t.index ["parent_id"], name: "idx_projects_parent_id"
    t.index ["rgt"], name: "index_projects_on_rgt"
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "projects_activities", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "activity_id", null: false
    t.index ["project_id", "activity_id"], name: "idx_projects_activities_1", unique: true
    t.index ["project_id"], name: "idx_projects_activities_2"
  end

  create_table "projects_activity_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "activity_id"
    t.integer "role_id"
    t.index ["project_id", "activity_id", "role_id"], name: "idx_projects_activity_roles_1", unique: true
    t.index ["project_id", "role_id"], name: "index_projects_activity_roles_on_project_id_and_role_id"
    t.index ["project_id"], name: "index_projects_activity_roles_on_project_id"
  end

  create_table "projects_easy_checklists", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "easy_checklist_id"
    t.integer "project_id"
    t.index ["easy_checklist_id"], name: "idx_ecl_pec_ecl_id"
    t.index ["project_id"], name: "idx_ecl_pec_project_id"
  end

  create_table "projects_trackers", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", default: 0, null: false
    t.integer "tracker_id", default: 0, null: false
    t.index ["project_id", "tracker_id"], name: "projects_trackers_unique", unique: true
    t.index ["project_id"], name: "projects_trackers_project_id"
  end

  create_table "queries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "name", default: "", null: false
    t.text "filters", limit: 16777215
    t.integer "user_id", default: 0, null: false
    t.text "column_names", limit: 16777215
    t.text "sort_criteria", limit: 16777215
    t.string "group_by"
    t.string "type"
    t.integer "visibility", default: 0
    t.text "options", limit: 16777215
    t.index ["project_id"], name: "index_queries_on_project_id"
    t.index ["user_id"], name: "index_queries_on_user_id"
  end

  create_table "queries_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "query_id", null: false
    t.integer "role_id", null: false
    t.index ["query_id", "role_id"], name: "queries_roles_ids", unique: true
  end

  create_table "re_artifact_properties", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "description", limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", default: 0
    t.integer "updated_by", default: 0
    t.integer "artifact_id"
    t.string "artifact_type"
    t.integer "project_id", default: 0
    t.decimal "rating_average", precision: 6, scale: 2, default: "0.0"
    t.integer "responsible_id"
    t.integer "comments_count", default: 0
    t.text "acceptance_criteria"
    t.integer "re_status_id"
  end

  create_table "re_artifact_relationships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "source_id"
    t.integer "sink_id"
    t.string "relation_type", limit: 50, default: "0", null: false
    t.integer "position"
  end

  create_table "re_change_requests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_goals", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_processwords", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "synonyms"
  end

  create_table "re_queries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "name"
    t.text "description"
    t.string "visibility"
    t.boolean "editable"
    t.text "source"
    t.text "sink"
    t.text "issue"
    t.text "order"
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "re_ratings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "user_id"
    t.string "re_artifact_properties_id"
    t.integer "value"
  end

  create_table "re_rationales", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_realizations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_id"
    t.integer "re_artifact_properties_id"
  end

  create_table "re_relationship_visualizations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string "visualization_typ"
    t.integer "re_attachment", default: 1
    t.integer "re_goal", default: 1
    t.integer "re_processword", default: 1
    t.integer "re_rationale", default: 1
    t.integer "re_requirement", default: 1
    t.integer "re_scenario", default: 1
    t.integer "re_section", default: 1
    t.integer "re_task", default: 1
    t.integer "re_user_profile", default: 1
    t.integer "re_use_case", default: 1
    t.integer "re_vision", default: 1
    t.integer "re_workarea", default: 1
    t.integer "dependency", default: 1
    t.integer "conflict", default: 1
    t.integer "rationale", default: 1
    t.integer "refinement", default: 1
    t.integer "part_of", default: 1
    t.integer "parentchild", default: 1
    t.integer "primary_actor", default: 1
    t.integer "actors", default: 1
    t.integer "diagram", default: 1
    t.integer "issue", default: 1
    t.integer "max_deep", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", default: 0
    t.integer "updated_by", default: 0
  end

  create_table "re_relationtypes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "relation_type"
    t.string "alias_name"
    t.string "color"
    t.integer "is_system_relation"
    t.integer "is_directed"
    t.integer "in_use"
  end

  create_table "re_requirements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_scenarios", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_sections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.text "value"
    t.integer "project_id", null: false
    t.datetime "updated_on"
  end

  create_table "re_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.string "label"
    t.string "alias_name"
    t.string "color"
    t.boolean "in_use"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "re_subtasks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "solution"
    t.integer "sub_type"
    t.string "name"
    t.integer "position"
    t.integer "re_task_id"
  end

  create_table "re_tasks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "start"
    t.string "end"
    t.string "frequency"
    t.text "difficult"
  end

  create_table "re_use_case_step_expansions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "re_use_case_step_id"
    t.integer "re_expansion_type"
    t.text "description"
    t.integer "position"
  end

  create_table "re_use_case_steps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "re_use_case_id"
    t.integer "step_type"
    t.text "description"
    t.integer "position"
  end

  create_table "re_use_cases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "trigger"
    t.text "precondition"
    t.text "postcondition"
    t.integer "goal_level"
  end

  create_table "re_user_profiles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_visions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "re_visualization_configs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string "visualization_type"
    t.string "configuration_type"
    t.string "configuration_name"
    t.string "configuration_value"
  end

  create_table "re_workareas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "repositories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", default: 0, null: false
    t.string "url", default: "", null: false
    t.string "login", limit: 60, default: ""
    t.string "password", default: ""
    t.string "root_url", default: ""
    t.string "type"
    t.string "path_encoding", limit: 64
    t.string "log_encoding", limit: 64
    t.text "extra_info", limit: 4294967295
    t.string "identifier"
    t.boolean "is_default", default: false
    t.datetime "created_on"
    t.string "easy_repository_url"
    t.string "easy_username"
    t.string "easy_password"
    t.string "easy_database_url"
    t.index ["project_id"], name: "index_repositories_on_project_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "position"
    t.boolean "assignable", default: true
    t.integer "builtin", default: 0, null: false
    t.text "permissions", limit: 16777215
    t.string "issues_visibility", limit: 30, default: "default", null: false
    t.string "users_visibility", limit: 30, default: "all", null: false
    t.string "time_entries_visibility", limit: 30, default: "all", null: false
    t.boolean "all_roles_managed", default: true, null: false
    t.text "settings", limit: 16777215
    t.boolean "limit_assignable_users", default: false, null: false
    t.string "easy_external_id"
    t.string "description"
    t.string "easy_printable_templates_visibility", limit: 30, default: "all", null: false
  end

  create_table "roles_managed_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "managed_role_id", null: false
    t.index ["role_id", "managed_role_id"], name: "index_roles_managed_roles_on_role_id_and_managed_role_id", unique: true
  end

  create_table "rorys_enqueued_tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "start_at"
    t.text "data", limit: 16777215
    t.string "executor"
    t.text "executions", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rys_features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rys_features_on_name"
    t.index ["name"], name: "unique_index_rys_features_name", unique: true
  end

  create_table "schema_easy_data_migrations", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "plugin"
    t.string "version", null: false
    t.text "options", limit: 16777215
    t.index ["plugin", "version"], name: "unique_schema_easy_data_migrations", unique: true
  end

  create_table "settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "value", limit: 16777215
    t.datetime "updated_on"
    t.index ["name"], name: "index_settings_on_name"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "test_case_issue_executions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "test_case_id"
    t.integer "issue_id"
    t.integer "result"
    t.integer "author_id", null: false
    t.text "comments", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_cases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "scenario", limit: 16777215
    t.text "expected_result", limit: 16777215
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.string "easy_external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "project_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_test_plans_on_author_id"
    t.index ["project_id"], name: "index_test_plans_on_project_id"
  end

  create_table "time_entries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id"
    t.integer "user_id", null: false
    t.integer "issue_id"
    t.float "hours", null: false
    t.text "comments", limit: 16777215
    t.integer "activity_id", null: false
    t.date "spent_on", null: false
    t.integer "tyear", null: false
    t.integer "tmonth", null: false
    t.integer "tweek", null: false
    t.datetime "created_on", null: false
    t.datetime "updated_on", null: false
    t.datetime "easy_range_from"
    t.datetime "easy_range_to"
    t.string "easy_external_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.boolean "easy_locked", default: false, null: false
    t.integer "easy_locked_by_id"
    t.datetime "easy_locked_at"
    t.integer "easy_unlocked_by_id"
    t.datetime "easy_unlocked_at"
    t.float "easy_divided_hours", default: 0.0, null: false
    t.integer "easy_timesheet_id"
    t.index ["activity_id"], name: "index_time_entries_on_activity_id"
    t.index ["created_on"], name: "idx_time_entries_created_on_desc"
    t.index ["created_on"], name: "index_time_entries_on_created_on"
    t.index ["easy_timesheet_id"], name: "idx_te_eti1"
    t.index ["issue_id"], name: "time_entries_issue_id"
    t.index ["project_id"], name: "time_entries_project_id"
    t.index ["spent_on"], name: "index_time_entries_on_spent_on"
    t.index ["user_id"], name: "index_time_entries_on_user_id"
  end

  create_table "tokens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false
    t.string "action", limit: 30, default: "", null: false
    t.string "value", limit: 40, default: "", null: false
    t.datetime "created_on", null: false
    t.datetime "updated_on"
    t.index ["user_id"], name: "index_tokens_on_user_id"
    t.index ["value"], name: "tokens_value", unique: true
  end

  create_table "trackers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.string "description"
    t.boolean "is_in_chlog", default: false, null: false
    t.integer "position"
    t.boolean "is_in_roadmap", default: true, null: false
    t.integer "fields_bits", default: 0
    t.integer "default_status_id"
    t.string "easy_color_scheme"
    t.string "internal_name"
    t.string "easy_external_id"
    t.boolean "easy_send_invitation"
    t.boolean "easy_do_not_allow_close_if_subtasks_opened"
    t.boolean "easy_do_not_allow_close_if_no_attachments"
    t.string "easy_icon"
    t.boolean "easy_distributed_tasks", default: false, null: false
    t.index ["internal_name"], name: "index_trackers_on_internal_name", unique: true
  end

  create_table "user_preferences", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false
    t.text "others", limit: 4294967295
    t.boolean "hide_mail", default: true
    t.string "time_zone"
    t.string "user_time_entry_setting", default: "hours", null: false
    t.string "hours_format"
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "userqueries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "filters", limit: 16777215
    t.integer "user_id", default: 0, null: false
    t.boolean "is_public", default: false, null: false
    t.text "column_names", limit: 16777215
    t.text "sort_criteria", limit: 16777215
    t.string "group_by"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "hashed_password", limit: 40, default: "", null: false
    t.string "firstname", limit: 30, default: "", null: false
    t.string "lastname", default: "", null: false
    t.text "description", limit: 16777215
    t.boolean "admin", default: false, null: false
    t.integer "status", default: 1, null: false
    t.datetime "last_login_on"
    t.string "language", limit: 5, default: ""
    t.integer "auth_source_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "type"
    t.string "identity_url"
    t.string "mail_notification", default: "", null: false
    t.string "salt", limit: 64
    t.boolean "must_change_passwd", default: false, null: false
    t.datetime "passwd_changed_on"
    t.boolean "easy_system_flag", default: false, null: false
    t.string "easy_external_id"
    t.integer "easy_user_type_id"
    t.boolean "easy_lesser_admin", default: false, null: false
    t.text "easy_lesser_admin_permissions", limit: 16777215
    t.text "easy_mail_signature", limit: 16777215
    t.boolean "self_registered", default: false
    t.string "easy_digest_token"
    t.string "sso_provider"
    t.string "sso_uuid"
    t.string "internal_name"
    t.string "easy_avatar_url"
    t.string "easy_zoom_user_uid", limit: 50
    t.integer "failed_login_attempts", default: 0, null: false
    t.datetime "blocked_at"
    t.integer "easy_online_status", default: 0, null: false
    t.datetime "easy_online_status_changed_at"
    t.index ["auth_source_id"], name: "index_users_on_auth_source_id"
    t.index ["id", "type"], name: "index_users_on_id_and_type"
    t.index ["sso_provider", "sso_uuid"], name: "idx_u_sso"
    t.index ["type"], name: "index_users_on_type"
  end

  create_table "versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", default: 0, null: false
    t.string "name", default: "", null: false
    t.text "description", limit: 16777215
    t.date "effective_date"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "wiki_page_title"
    t.string "status", default: "open"
    t.string "sharing", default: "none", null: false
    t.integer "easy_version_category_id"
    t.string "easy_external_id"
    t.index ["project_id"], name: "versions_project_id"
    t.index ["sharing"], name: "index_versions_on_sharing"
  end

  create_table "view_customizes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "path_pattern", default: "", null: false
    t.text "code", limit: 4294967295, null: false
    t.boolean "is_enabled", default: true, null: false
    t.boolean "is_private", default: false, null: false
    t.integer "author_id", default: 0, null: false
    t.string "insertion_position", default: "html_head", null: false
    t.string "customize_type", default: "javascript", null: false
    t.string "comments", default: "", null: false
    t.string "project_pattern", default: "", null: false
  end

  create_table "watchers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "watchable_type", default: "", null: false
    t.integer "watchable_id", default: 0, null: false
    t.integer "user_id"
    t.index ["user_id", "watchable_type"], name: "watchers_user_id_type"
    t.index ["user_id"], name: "index_watchers_on_user_id"
    t.index ["watchable_id", "watchable_type"], name: "index_watchers_on_watchable_id_and_watchable_type"
  end

  create_table "wiki_content_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "wiki_content_id", null: false
    t.integer "page_id", null: false
    t.integer "author_id"
    t.binary "data", limit: 4294967295
    t.string "compression", limit: 6, default: ""
    t.string "comments", limit: 1024, default: ""
    t.datetime "updated_on", null: false
    t.integer "version", null: false
    t.index ["updated_on"], name: "index_wiki_content_versions_on_updated_on"
    t.index ["wiki_content_id"], name: "wiki_content_versions_wcid"
  end

  create_table "wiki_contents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "page_id", null: false
    t.integer "author_id"
    t.text "text", limit: 4294967295
    t.string "comments", limit: 1024, default: ""
    t.datetime "updated_on", null: false
    t.integer "version", null: false
    t.index ["author_id"], name: "index_wiki_contents_on_author_id"
    t.index ["page_id"], name: "wiki_contents_page_id"
  end

  create_table "wiki_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "wiki_id", null: false
    t.string "title", null: false
    t.datetime "created_on", null: false
    t.boolean "protected", default: false, null: false
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_wiki_pages_on_parent_id"
    t.index ["wiki_id", "title"], name: "wiki_pages_wiki_id_title"
    t.index ["wiki_id"], name: "index_wiki_pages_on_wiki_id"
  end

  create_table "wiki_redirects", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "wiki_id", null: false
    t.string "title"
    t.string "redirects_to"
    t.datetime "created_on", null: false
    t.integer "redirects_to_wiki_id", null: false
    t.index ["wiki_id", "title"], name: "wiki_redirects_wiki_id_title"
    t.index ["wiki_id"], name: "index_wiki_redirects_on_wiki_id"
  end

  create_table "wikis", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "start_page", null: false
    t.integer "status", default: 1, null: false
    t.index ["project_id"], name: "wikis_project_id"
  end

  create_table "workflows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "tracker_id", default: 0, null: false
    t.integer "old_status_id", default: 0, null: false
    t.integer "new_status_id", default: 0, null: false
    t.integer "role_id", default: 0, null: false
    t.boolean "assignee", default: false, null: false
    t.boolean "author", default: false, null: false
    t.string "type", limit: 30
    t.string "field_name", limit: 30
    t.string "rule", limit: 30
    t.index ["new_status_id"], name: "index_workflows_on_new_status_id"
    t.index ["old_status_id"], name: "index_workflows_on_old_status_id"
    t.index ["role_id", "tracker_id", "old_status_id"], name: "wkfs_role_tracker_old_status"
    t.index ["role_id"], name: "index_workflows_on_role_id"
    t.index ["tracker_id"], name: "index_workflows_on_tracker_id"
  end

end
