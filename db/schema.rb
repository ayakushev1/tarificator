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

ActiveRecord::Schema.define(version: 20130831021502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_authority_actions", force: true do |t|
    t.integer  "role_type_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_authority_actions", ["role_type_id"], name: "index_admin_authority_actions_on_role_type_id", using: :btree

  create_table "admin_authority_role_authorities", force: true do |t|
    t.integer  "role_id"
    t.string   "name"
    t.text     "description"
    t.string   "allowed_to_give_authorities"
    t.string   "action"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_authority_role_authorities", ["role_id"], name: "index_admin_authority_role_authorities_on_role_id", using: :btree

  create_table "admin_authority_role_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_authority_roles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "role_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_authority_roles", ["role_type_id"], name: "index_admin_authority_roles_on_role_type_id", using: :btree

  create_table "admin_authority_url_access_authorities", force: true do |t|
    t.string   "controller_path"
    t.string   "route_path"
    t.string   "controller"
    t.string   "action"
    t.boolean  "restricted"
    t.string   "access_authorized_roles"
    t.string   "condition"
    t.string   "method_to_call_before_condition"
    t.boolean  "processed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_authority_user_authorities", force: true do |t|
    t.integer  "user_id"
    t.string   "authorize_roles"
    t.string   "own_crud_roles"
    t.string   "other_crud_roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_authority_user_authorities", ["user_id"], name: "index_admin_authority_user_authorities_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "surname"
    t.string   "firstname"
    t.date     "date_of_birth"
    t.integer  "main_location_id"
  end

end
