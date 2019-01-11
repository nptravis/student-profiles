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

ActiveRecord::Schema.define(version: 20190111011638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "absences"
    t.integer "tardies"
    t.integer "student_id"
    t.integer "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "student_id"
    t.integer "user_id"
  end

  create_table "course_standards", force: :cascade do |t|
    t.integer "course_id"
    t.integer "standard_id"
  end

  create_table "course_terms", force: :cascade do |t|
    t.integer "course_id"
    t.integer "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.string "course_number"
    t.integer "dcid"
    t.integer "school_id"
    t.integer "department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "school_id"
    t.integer "dcid"
    t.integer "ps_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer "student_id"
    t.integer "standard_id"
    t.string "grade"
    t.integer "section_id"
    t.integer "term_id"
    t.string "semester"
  end

  create_table "quarter_comments", force: :cascade do |t|
    t.string "content"
    t.integer "teacher_id"
    t.integer "student_id"
    t.integer "section_id"
  end

  create_table "schedule_data", force: :cascade do |t|
    t.string "expression"
    t.string "course_id"
    t.integer "student_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id"
    t.integer "teacher_id"
    t.string "section_number"
    t.string "expression"
    t.integer "dcid"
    t.integer "term_id"
    t.string "room"
    t.integer "grade_level"
  end

  create_table "semester_comments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
    t.integer "teacher_id"
    t.string "content"
    t.string "semester"
  end

  create_table "standard_terms", force: :cascade do |t|
    t.integer "standard_id"
    t.integer "term_id"
  end

  create_table "standards", force: :cascade do |t|
    t.string "standard_name"
    t.string "identifier"
    t.integer "dcid"
    t.integer "parent_standard_dcid"
    t.string "description"
  end

  create_table "student_sections", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "lastfirst"
    t.string "student_number"
    t.string "grade_level"
    t.integer "dcid"
    t.integer "school_id"
    t.string "email"
    t.string "mailing_city"
    t.string "mailing_zip"
    t.string "mailing_street_1"
    t.string "mailing_street_2"
    t.string "guardian_names"
    t.string "mailing_state"
    t.integer "ps_id"
    t.string "alert"
    t.string "home_room"
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
    t.integer "ps_id"
  end

  create_table "terms", force: :cascade do |t|
    t.integer "term_code"
  end

  create_table "trad_grades", force: :cascade do |t|
    t.integer "student_id"
    t.string "grade"
    t.integer "section_id"
    t.integer "term_id"
    t.string "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "percent"
  end

  create_table "transcripts", force: :cascade do |t|
    t.integer "student_id"
    t.decimal "cumulative_gpa"
    t.decimal "g9_sem1_gpa"
    t.decimal "g9_sem2_gpa"
    t.decimal "g9_cumulative_gpa"
    t.decimal "g10_sem1_gpa"
    t.decimal "g10_sem2_gpa"
    t.decimal "g10_cumulative_gpa"
    t.decimal "g11_sem1_gpa"
    t.decimal "g11_sem2_gpa"
    t.decimal "g11_cumulative_gpa"
    t.decimal "g12_sem1_gpa"
    t.decimal "g12_sem2_gpa"
    t.decimal "g12_cumulative_gpa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "eng_credit"
    t.decimal "mat_credit"
    t.decimal "sci_credit"
    t.decimal "soc_credit"
    t.decimal "arts_credit"
    t.decimal "pe_credit"
    t.decimal "rel_credit"
    t.decimal "mod_credit"
    t.decimal "health_credit"
    t.decimal "total_credit"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "image_url"
    t.boolean "admin", default: false
  end

end
