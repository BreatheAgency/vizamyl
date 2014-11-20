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

ActiveRecord::Schema.define(version: 20141120161100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "locale",                 default: "en", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answer_translations", force: true do |t|
    t.integer  "answer_id",  null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "answer_translations", ["answer_id"], name: "index_answer_translations_on_answer_id", using: :btree
  add_index "answer_translations", ["locale"], name: "index_answer_translations_on_locale", using: :btree

  create_table "answers", force: true do |t|
    t.text    "body"
    t.boolean "correct",     default: false
    t.integer "question_id"
  end

  create_table "chapter_translations", force: true do |t|
    t.integer  "chapter_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "short_title"
  end

  add_index "chapter_translations", ["chapter_id"], name: "index_chapter_translations_on_chapter_id", using: :btree
  add_index "chapter_translations", ["locale"], name: "index_chapter_translations_on_locale", using: :btree

  create_table "chapters", force: true do |t|
    t.integer  "position"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_title"
  end

  create_table "image_translations", force: true do |t|
    t.integer  "image_id",     null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subject_area"
    t.string   "source"
  end

  add_index "image_translations", ["image_id"], name: "index_image_translations_on_image_id", using: :btree
  add_index "image_translations", ["locale"], name: "index_image_translations_on_locale", using: :btree

  create_table "images", force: true do |t|
    t.string "page_id"
    t.string "title"
    t.string "subject_area"
    t.string "source"
  end

  create_table "interactive_source_translations", force: true do |t|
    t.integer  "interactive_source_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  add_index "interactive_source_translations", ["interactive_source_id"], name: "index_interactive_source_translations_on_interactive_source_id", using: :btree
  add_index "interactive_source_translations", ["locale"], name: "index_interactive_source_translations_on_locale", using: :btree

  create_table "interactive_sources", force: true do |t|
    t.integer "subject_id"
    t.string  "subject_type"
    t.string  "source"
    t.string  "label"
    t.integer "height"
  end

  create_table "interactive_translations", force: true do |t|
    t.integer  "interactive_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "subject_area"
  end

  add_index "interactive_translations", ["interactive_id"], name: "index_interactive_translations_on_interactive_id", using: :btree
  add_index "interactive_translations", ["locale"], name: "index_interactive_translations_on_locale", using: :btree

  create_table "interactives", force: true do |t|
    t.string "page_id"
    t.string "title"
    t.text   "body"
    t.string "subject_area"
  end

  create_table "progressions", force: true do |t|
    t.integer "user_id"
    t.integer "step_id"
    t.float   "amount",  default: 0.0
  end

  add_index "progressions", ["step_id", "user_id"], name: "index_progressions_on_step_id_and_user_id", unique: true, using: :btree

  create_table "question_intro_translations", force: true do |t|
    t.integer  "question_intro_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "subject_area"
  end

  add_index "question_intro_translations", ["locale"], name: "index_question_intro_translations_on_locale", using: :btree
  add_index "question_intro_translations", ["question_intro_id"], name: "index_question_intro_translations_on_question_intro_id", using: :btree

  create_table "question_intros", force: true do |t|
    t.string "page_id"
    t.string "title"
    t.text   "body"
    t.string "subject_area"
  end

  create_table "question_rounds", force: true do |t|
    t.integer "subject_id"
    t.string  "subject_type"
  end

  create_table "question_translations", force: true do |t|
    t.integer  "question_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "title"
  end

  add_index "question_translations", ["locale"], name: "index_question_translations_on_locale", using: :btree
  add_index "question_translations", ["question_id"], name: "index_question_translations_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.text    "title"
    t.integer "question_round_id"
  end

  create_table "steps", force: true do |t|
    t.integer "chapter_id"
    t.integer "position"
    t.integer "page_id"
    t.string  "page_type"
    t.boolean "visible",    default: true
  end

  create_table "test_translations", force: true do |t|
    t.integer  "test_id",      null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subject_area"
  end

  add_index "test_translations", ["locale"], name: "index_test_translations_on_locale", using: :btree
  add_index "test_translations", ["test_id"], name: "index_test_translations_on_test_id", using: :btree

  create_table "tests", force: true do |t|
    t.string "page_id"
    t.string "title"
    t.string "subject_area"
  end

  create_table "text_translations", force: true do |t|
    t.integer  "text_id",       null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "subject_area"
    t.text     "abbreviations"
  end

  add_index "text_translations", ["locale"], name: "index_text_translations_on_locale", using: :btree
  add_index "text_translations", ["text_id"], name: "index_text_translations_on_text_id", using: :btree

  create_table "texts", force: true do |t|
    t.string "page_id"
    t.string "title"
    t.text   "body"
    t.string "subject_area"
    t.text   "abbreviations"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "locale",                 default: "en",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                                  null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.boolean  "super_user",             default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "video_translations", force: true do |t|
    t.integer  "video_id",      null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "subject_area"
    t.string   "source"
    t.text     "abbreviations"
  end

  add_index "video_translations", ["locale"], name: "index_video_translations_on_locale", using: :btree
  add_index "video_translations", ["video_id"], name: "index_video_translations_on_video_id", using: :btree

  create_table "videos", force: true do |t|
    t.string  "page_id"
    t.string  "title"
    t.text    "body"
    t.string  "subject_area"
    t.string  "source"
    t.text    "abbreviations"
    t.boolean "mandatory",     default: true
  end

end
