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

ActiveRecord::Schema.define(version: 20140520134953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.boolean  "image_processed"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", using: :btree
  add_index "admin_users", ["username"], name: "index_admin_users_on_username", unique: true, using: :btree

  create_table "agendas", force: true do |t|
    t.integer  "cidade_id"
    t.datetime "data"
    t.string   "local"
    t.string   "endereco"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "passbook"
    t.boolean  "published"
    t.text     "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foto_id"
    t.string   "nome"
    t.string   "meetup"
  end

  add_index "agendas", ["data"], name: "index_agendas_on_data", using: :btree
  add_index "agendas", ["foto_id"], name: "index_agendas_on_foto_id", using: :btree
  add_index "agendas", ["published"], name: "index_agendas_on_published", using: :btree

  create_table "cidades", force: true do |t|
    t.integer  "estado_id"
    t.string   "cidade"
    t.string   "organizador"
    t.string   "organizador_email"
    t.string   "website"
    t.string   "github"
    t.string   "twitter"
    t.string   "facebook"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.text     "descricao"
    t.string   "organizador_contato"
  end

  add_index "cidades", ["cidade"], name: "index_cidades_on_cidade", using: :btree
  add_index "cidades", ["published"], name: "index_cidades_on_published", using: :btree

  create_table "contents", force: true do |t|
    t.string   "title"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "published"
    t.integer  "modified_by"
    t.integer  "created_by"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
  end

  add_index "contents", ["created_by"], name: "index_contents_on_created_by", using: :btree
  add_index "contents", ["modified_by"], name: "index_contents_on_modified_by", using: :btree
  add_index "contents", ["permalink"], name: "index_contents_on_permalink", unique: true, using: :btree
  add_index "contents", ["position"], name: "index_contents_on_position", using: :btree

  create_table "downloads", force: true do |t|
    t.string   "titulo"
    t.string   "url"
    t.string   "autor"
    t.integer  "posicao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "downloads", ["posicao"], name: "index_downloads_on_posicao", using: :btree

  create_table "estados", force: true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faq_groups", force: true do |t|
    t.string   "title"
    t.integer  "position"
    t.boolean  "published",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faq_groups", ["position"], name: "index_faq_groups_on_position", using: :btree
  add_index "faq_groups", ["published"], name: "index_faq_groups_on_published", using: :btree

  create_table "faqs", force: true do |t|
    t.integer  "faq_group_id"
    t.integer  "position"
    t.boolean  "published",    default: false
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "useful_yes",   default: 0
    t.integer  "useful_no",    default: 0
  end

  add_index "faqs", ["position"], name: "index_faqs_on_position", using: :btree
  add_index "faqs", ["published"], name: "index_faqs_on_published", using: :btree

  create_table "fotos", force: true do |t|
    t.integer  "agenda_id"
    t.string   "descricao"
    t.string   "flickr_album_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "palestrantes", force: true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "website"
    t.string   "twitter"
    t.string   "github"
    t.string   "linkedin"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "mini_curriculo"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "intro"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "permalink"
  end

  add_index "posts", ["permalink"], name: "index_posts_on_permalink", unique: true, using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["email"], name: "index_subscriptions_on_email", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.integer  "palestrante_id"
    t.integer  "agenda_id"
    t.string   "titulo"
    t.text     "descricao"
    t.string   "youtube"
    t.boolean  "published"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "podcast_stream_url"
    t.string   "podcast_duration"
  end

end
