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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130622103730) do

  create_table "channel_groups", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["name"], :name => "index_channel_groups_on_name", :unique => true
  end

  create_table "channels", :force => true do |t|
    t.integer  "channel_group_id", :null => false
    t.string   "name",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.index ["channel_group_id"], :name => "index_channels_on_channel_group_id"
    t.foreign_key ["channel_group_id"], "channel_groups", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_channel_group_id"
  end

  create_table "titles", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "kana"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true
  end

  create_table "user_channels", :force => true do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["channel_id", "user_id"], :name => "index_user_channels_on_channel_id_and_user_id", :unique => true
    t.index ["user_id"], :name => "fk__user_channels_user_id"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_user_channels_channel_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_user_channels_user_id"
  end

end
