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

ActiveRecord::Schema.define(version: 20180911235733) do

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "student_id"
    t.integer "user_id"
  end

  create_table "course_standards", force: :cascade do |t|
    t.integer "course_id"
    t.integer "standard_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.string "course_number"
    t.integer "dcid"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "student_id"
    t.integer "standard_id"
    t.string "grade"
    t.integer "section_id"
    t.integer "termid"
    t.string "semester"
  end

  create_table "schedule_data", force: :cascade do |t|
    t.string "expression"
    t.string "course_id"
    t.integer "student_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id"
    t.integer "teacher_id"
    t.string "course_number"
    t.string "course_name"
    t.string "section_number"
    t.string "expression"
    t.integer "dcid"
    t.integer "termid"
    t.string "room"
  end

  create_table "semester_comments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
    t.integer "teacher_id"
    t.string "content"
    t.string "semester"
  end

  create_table "standards", force: :cascade do |t|
    t.string "standard_name"
    t.string "identifier"
    t.integer "dcid"
  end

  create_table "student_sections", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "lastfirst"
    t.string "student_number"
    t.string "gradelevel"
    t.integer "dcid"
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email"
    t.string "lastfirst"
    t.integer "dcid"
    t.string "teacher_number"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "image_url"
    t.boolean "admin", default: false
  end

end
