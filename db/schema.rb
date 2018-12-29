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

ActiveRecord::Schema.define(version: 2018_12_29_033903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "profile", default: {}
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_keys_on_token", unique: true
  end

  create_table "article_tags", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_tags_on_article_id"
    t.index ["tag_id"], name: "index_article_tags_on_tag_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.text "body"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.boolean "featured", default: false
    t.boolean "deleted", default: false
    t.jsonb "style", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_articles_on_name", unique: true
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.boolean "approved", default: false
    t.boolean "featured", default: false
    t.boolean "deleted", default: false
    t.jsonb "style", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.boolean "approved", default: false
    t.boolean "featured", default: false
    t.boolean "deleted", default: false
    t.jsonb "style", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
    t.index ["slug"], name: "index_languages_on_slug", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.boolean "approved", default: false
    t.boolean "featured", default: false
    t.boolean "deleted", default: false
    t.jsonb "style", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "tool_categories", force: :cascade do |t|
    t.bigint "tool_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tool_categories_on_category_id"
    t.index ["tool_id"], name: "index_tool_categories_on_tool_id"
  end

  create_table "tool_languages", force: :cascade do |t|
    t.bigint "tool_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_tool_languages_on_language_id"
    t.index ["tool_id"], name: "index_tool_languages_on_tool_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.boolean "featured", default: false
    t.boolean "deleted", default: false
    t.jsonb "links", default: {}
    t.jsonb "style", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tools_on_name", unique: true
    t.index ["slug"], name: "index_tools_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "tool_categories", "categories"
  add_foreign_key "tool_categories", "tools"
  add_foreign_key "tool_languages", "languages"
  add_foreign_key "tool_languages", "tools"
end
