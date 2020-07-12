# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20200712182918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "postgres_fdw"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "locale",                 limit: 255, default: "en",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "content_admin",                      default: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answer_translations", force: :cascade do |t|
    t.integer  "answer_id",              null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "answer_translations", ["answer_id"], name: "index_answer_translations_on_answer_id", using: :btree
  add_index "answer_translations", ["locale"], name: "index_answer_translations_on_locale", using: :btree

  create_table "answers", force: :cascade do |t|
    t.text    "body"
    t.boolean "correct",     default: false
    t.integer "question_id"
  end

  create_table "chapter_translations", force: :cascade do |t|
    t.integer  "chapter_id",              null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       limit: 255, null: false
    t.string   "short_title", limit: 255
  end

  add_index "chapter_translations", ["chapter_id"], name: "index_chapter_translations_on_chapter_id", using: :btree
  add_index "chapter_translations", ["locale"], name: "index_chapter_translations_on_locale", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.integer  "position"
    t.string   "title",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_title", limit: 255
    t.boolean  "hidden",                  default: false
  end

  create_table "four_b_translations", force: :cascade do |t|
    t.integer  "four_b_id",                null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        limit: 255
    t.string   "subject_area", limit: 255
  end

  add_index "four_b_translations", ["four_b_id"], name: "index_four_b_translations_on_four_b_id", using: :btree
  add_index "four_b_translations", ["locale"], name: "index_four_b_translations_on_locale", using: :btree

  create_table "four_bs", force: :cascade do |t|
    t.string "page_id",      limit: 255
    t.string "title",        limit: 255
    t.string "subject_area", limit: 255
  end

  create_table "image_source_translations", force: :cascade do |t|
    t.integer  "image_source_id",             null: false
    t.string   "locale",          limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source",          limit: 255
  end

  add_index "image_source_translations", ["image_source_id"], name: "index_image_source_translations_on_image_source_id", using: :btree
  add_index "image_source_translations", ["locale"], name: "index_image_source_translations_on_locale", using: :btree

  create_table "image_sources", force: :cascade do |t|
    t.integer "subject_id"
    t.string  "subject_type", limit: 255
    t.string  "source",       limit: 255
  end

  create_table "image_translations", force: :cascade do |t|
    t.integer  "image_id",                 null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        limit: 255
    t.string   "subject_area", limit: 255
    t.string   "source",       limit: 255
  end

  add_index "image_translations", ["image_id"], name: "index_image_translations_on_image_id", using: :btree
  add_index "image_translations", ["locale"], name: "index_image_translations_on_locale", using: :btree

  create_table "images", force: :cascade do |t|
    t.string "page_id",      limit: 255
    t.string "title",        limit: 255
    t.string "subject_area", limit: 255
    t.string "source",       limit: 255
  end

  create_table "interactive_source_translations", force: :cascade do |t|
    t.integer  "interactive_source_id",             null: false
    t.string   "locale",                limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label",                 limit: 255
  end

  add_index "interactive_source_translations", ["interactive_source_id"], name: "index_interactive_source_translations_on_interactive_source_id", using: :btree
  add_index "interactive_source_translations", ["locale"], name: "index_interactive_source_translations_on_locale", using: :btree

  create_table "interactive_sources", force: :cascade do |t|
    t.integer "subject_id"
    t.string  "subject_type", limit: 255
    t.string  "source",       limit: 255
    t.string  "label",        limit: 255
    t.integer "height"
  end

  create_table "interactive_translations", force: :cascade do |t|
    t.integer  "interactive_id",             null: false
    t.string   "locale",         limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",          limit: 255
    t.text     "body"
    t.string   "subject_area",   limit: 255
  end

  add_index "interactive_translations", ["interactive_id"], name: "index_interactive_translations_on_interactive_id", using: :btree
  add_index "interactive_translations", ["locale"], name: "index_interactive_translations_on_locale", using: :btree

  create_table "interactives", force: :cascade do |t|
    t.string "page_id",      limit: 255
    t.string "title",        limit: 255
    t.text   "body"
    t.string "subject_area", limit: 255
  end

  create_table "progressions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "step_id"
    t.float    "amount",     default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progressions", ["step_id", "user_id"], name: "index_progressions_on_step_id_and_user_id", unique: true, using: :btree

  create_table "question_intro_translations", force: :cascade do |t|
    t.integer  "question_intro_id",             null: false
    t.string   "locale",            limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",             limit: 255
    t.text     "body"
    t.string   "subject_area",      limit: 255
  end

  add_index "question_intro_translations", ["locale"], name: "index_question_intro_translations_on_locale", using: :btree
  add_index "question_intro_translations", ["question_intro_id"], name: "index_question_intro_translations_on_question_intro_id", using: :btree

  create_table "question_intros", force: :cascade do |t|
    t.string "page_id",      limit: 255
    t.string "title",        limit: 255
    t.text   "body"
    t.string "subject_area", limit: 255
  end

  create_table "question_rounds", force: :cascade do |t|
    t.integer "subject_id"
    t.string  "subject_type", limit: 255
  end

  create_table "question_translations", force: :cascade do |t|
    t.integer  "question_id",                    null: false
    t.string   "locale",             limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "title"
    t.text     "explanation_source"
    t.string   "correct_title"
    t.string   "incorrect_title"
  end

  add_index "question_translations", ["locale"], name: "index_question_translations_on_locale", using: :btree
  add_index "question_translations", ["question_id"], name: "index_question_translations_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text    "title"
    t.integer "question_round_id"
    t.text    "explanation_source"
    t.boolean "test_case",          default: false
    t.string  "correct_title"
    t.string  "incorrect_title"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "chapter_id"
    t.integer "position"
    t.integer "page_id"
    t.string  "page_type",  limit: 255
    t.boolean "visible",                default: true
    t.text    "locales",                default: [],   null: false, array: true
  end

  add_index "steps", ["locales"], name: "index_steps_on_locales", using: :gin

  create_table "test_translations", force: :cascade do |t|
    t.integer  "test_id",                       null: false
    t.string   "locale",            limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject_area",      limit: 255
    t.text     "results_incorrect"
    t.text     "results_correct"
    t.string   "results_title"
  end

  add_index "test_translations", ["locale"], name: "index_test_translations_on_locale", using: :btree
  add_index "test_translations", ["test_id"], name: "index_test_translations_on_test_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.string  "page_id",           limit: 255
    t.string  "subject_area",      limit: 255
    t.integer "failure_step_id"
    t.text    "results_correct"
    t.text    "results_incorrect"
    t.string  "results_title"
    t.boolean "test_case",                     default: false
  end

  create_table "text_translations", force: :cascade do |t|
    t.integer  "text_id",                   null: false
    t.string   "locale",        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",         limit: 255
    t.text     "body"
    t.string   "subject_area",  limit: 255
    t.text     "abbreviations"
  end

  add_index "text_translations", ["locale"], name: "index_text_translations_on_locale", using: :btree
  add_index "text_translations", ["text_id"], name: "index_text_translations_on_text_id", using: :btree

  create_table "texts", force: :cascade do |t|
    t.string "page_id",       limit: 255
    t.string "title",         limit: 255
    t.text   "body"
    t.string "subject_area",  limit: 255
    t.text   "abbreviations"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255, default: "",    null: false
    t.string   "encrypted_password",              limit: 255, default: "",    null: false
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token",              limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",               limit: 255
    t.string   "locale",                          limit: 255, default: "en",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salutation"
    t.string   "first_name",                      limit: 255,                 null: false
    t.string   "last_name",                       limit: 255,                 null: false
    t.boolean  "super_user",                                  default: false
    t.boolean  "in_person",                                   default: false
    t.datetime "failed_round_one_at"
    t.datetime "failed_round_two_at"
    t.datetime "passed_round_one_at"
    t.datetime "passed_round_two_at"
    t.boolean  "terms_and_conditions_opt_in",                 default: false
    t.boolean  "marketing_overall_opt_in",                    default: false
    t.boolean  "marketing_email_opt_in",                      default: false
    t.boolean  "marketing_post_opt_in",                       default: false
    t.boolean  "marketing_representative_opt_in",             default: false
    t.text     "institution",                                 default: ""
    t.string   "invite_code"
    t.boolean  "cookies_opt_in",                              default: false
    t.boolean  "fast_forward",                                default: false
    t.string   "origin",                                      default: "en",  null: false
    t.boolean  "privacy_opt_in",                              default: false
    t.string   "department"
    t.string   "city_or_state"
    t.string   "primary_specialty"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "video_translations", force: :cascade do |t|
    t.integer  "video_id",                  null: false
    t.string   "locale",        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",         limit: 255
    t.text     "body"
    t.string   "subject_area",  limit: 255
    t.string   "source",        limit: 255
    t.text     "abbreviations"
  end

  add_index "video_translations", ["locale"], name: "index_video_translations_on_locale", using: :btree
  add_index "video_translations", ["video_id"], name: "index_video_translations_on_video_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string  "page_id",       limit: 255
    t.string  "title",         limit: 255
    t.text    "body"
    t.string  "subject_area",  limit: 255
    t.string  "source",        limit: 255
    t.text    "abbreviations"
    t.boolean "mandatory",                 default: true
  end

end
