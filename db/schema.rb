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

ActiveRecord::Schema.define(version: 20_130_715_231_258) do

  create_table 'channel_groups', force: true do |t|
    t.string 'name',       null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['name'], name: 'index_channel_groups_on_name', unique: true
  end

  create_table 'channels', force: true do |t|
    t.integer 'channel_group_id', null: false
    t.string 'name',             null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['channel_group_id'], name: 'index_channels_on_channel_group_id'
    t.foreign_key ['channel_group_id'], 'channel_groups', ['id'], on_update: :no_action, on_delete: :no_action, name: 'fk_channels_channel_group_id'
  end

  create_table 'oauth_access_grants', force: true do |t|
    t.integer 'resource_owner_id', null: false
    t.integer 'application_id',    null: false
    t.string 'token',             null: false
    t.integer 'expires_in',        null: false
    t.string 'redirect_uri',      null: false
    t.datetime 'created_at',        null: false
    t.datetime 'revoked_at'
    t.string 'scopes'
    t.index ['token'], name: 'index_oauth_access_grants_on_token', unique: true
  end

  create_table 'oauth_access_tokens', force: true do |t|
    t.integer 'resource_owner_id'
    t.integer 'application_id',    null: false
    t.string 'token',             null: false
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.datetime 'revoked_at'
    t.datetime 'created_at',        null: false
    t.string 'scopes'
    t.index ['refresh_token'], name: 'index_oauth_access_tokens_on_refresh_token', unique: true
    t.index ['resource_owner_id'], name: 'index_oauth_access_tokens_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_tokens_on_token', unique: true
  end

  create_table 'oauth_applications', force: true do |t|
    t.string 'name',         null: false
    t.string 'uid',          null: false
    t.string 'secret',       null: false
    t.string 'redirect_uri', null: false
    t.integer 'owner_id',     null: false
    t.string 'owner_type'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(owner_id owner_type), name: 'index_oauth_applications_on_owner_id_and_owner_type'
    t.index ['uid'], name: 'index_oauth_applications_on_uid', unique: true
  end

  create_table 'titles', force: true do |t|
    t.string 'name',        null: false
    t.string 'kana'
    t.datetime 'started_at'
    t.datetime 'finished_at'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['kana'], name: 'index_titles_on_kana'
  end

  create_table 'users', force: true do |t|
    t.string 'provider',   null: false
    t.string 'uid',        null: false
    t.string 'name',       null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(provider uid), name: 'index_users_on_provider_and_uid', unique: true
  end

  create_table 'user_channels', force: true do |t|
    t.integer 'user_id'
    t.integer 'channel_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(channel_id user_id), name: 'index_user_channels_on_channel_id_and_user_id', unique: true
    t.index ['user_id'], name: 'fk__user_channels_user_id'
    t.foreign_key ['channel_id'], 'channels', ['id'], on_update: :no_action, on_delete: :no_action, name: 'fk_user_channels_channel_id'
    t.foreign_key ['user_id'], 'users', ['id'], on_update: :no_action, on_delete: :no_action, name: 'fk_user_channels_user_id'
  end

  create_table 'watchings', force: true do |t|
    t.integer 'user_id',    null: false
    t.integer 'title_id',   null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['title_id'], name: 'fk__watchings_title_id'
    t.index %w(user_id title_id), name: 'index_watchings_on_user_id_and_title_id', unique: true
    t.index ['user_id'], name: 'fk__watchings_user_id'
    t.foreign_key ['title_id'], 'titles', ['id'], on_update: :no_action, on_delete: :no_action, name: 'fk_watchings_title_id'
    t.foreign_key ['user_id'], 'users', ['id'], on_update: :no_action, on_delete: :no_action, name: 'fk_watchings_user_id'
  end

end
