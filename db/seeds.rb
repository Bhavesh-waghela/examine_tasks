# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
user = User.find_or_create_by(name: "Bhavesh Admin")

["RAVEN", "STENBERG", "INPUT_DIAGRAMMATIC"].each do |ques_type|
  ["EASY", "MEDIUM", "HARD"].each do |diff_type|
    tlx_question1 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How difficult were these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question2 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How much mental activity (e.g. thinking, calculating, remembering, etc.) was required to complete these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question3 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How much physical activity was needed to complete these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question4 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How much time pressure did you feel while performing the tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question5 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How satisfied were you with your performance in completing these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question6 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How hard did you have to work mentally to complete these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    tlx_question7 = Question.create(:user_id => user.id, :is_tlx => true, :question => "How insecure, irritated, and stressed did you feel when performing these tasks?", :countdown_timer => 15, :q_type => Question.q_types[ques_type], :difficulty_level=> Question.difficulty_levels[diff_type])
    [tlx_question1, tlx_question2, tlx_question3, tlx_question4, tlx_question5, tlx_question6, tlx_question7].each do |tlx_question|

      option1 = Option.create(:question_id => tlx_question.id, :option => "Extremely low")
      option2 = Option.create(:question_id => tlx_question.id, :option => "Very low")
      option3 = Option.create(:question_id => tlx_question.id, :option => "Moderately low")
      option4 = Option.create(:question_id => tlx_question.id, :option => "Neither low nor High")
      option5 = Option.create(:question_id => tlx_question.id, :option => "Moderately high")
      option6 = Option.create(:question_id => tlx_question.id, :option => "Very high")
      option7 = Option.create(:question_id => tlx_question.id, :option => "Extremely high")

    end
  end  
end

xlsx = Roo::Spreadsheet.open("#{Rails.root}/public/sternberg/w_list.xlsx")
set_of_words = []
xlsx.each_with_pagename do |name, sheet|
  sheet.each_with_index(id: 'rank', name: 'Word') do |hash, index|
    set_of_words << hash[:name]
  end
end

easy_questions = set_of_words[1..200]
medium_questions = set_of_words[202..601]
hard_questions = set_of_words[603..set_of_words.length-1]

def generate_stenberg_questions(level, arr_name, max_options, question_value, c_timer, s_timer, user)
  10.times do |i|
    random_options = arr_name.sample(max_options)
    sample_arr = arr_name.sample(question_value)
    question_string = sample_arr.join(" ")
    final_options = random_options + sample_arr
    question = Question.create(:user_id => user.id, :description => "Read once only, concentrating briefly for a few seconds on each word, afterwards select as many of the words as you can remember.", :question => question_string, :q_type => Question.q_types["STENBERG"], :difficulty_level=> Question.difficulty_levels[level], :countdown_timer => c_timer, :sternberg_timer => s_timer)
    final_options.each do |f_option|
      Option.create(:question_id => question.id, :option => f_option)
    end
  end
end

def generate_raven_task_questions(level, timer, user)
  [*1..10].each do |i|
    question = Question.create(:user_id => user.id, :description => "Please select the appropriate image for the given image which you think is the best match, there is only one possible solution so please look for all options carefully.", :q_type => Question.q_types["RAVEN"], :difficulty_level=> Question.difficulty_levels[level], :countdown_timer => timer)
    question.image.attach(io: File.open("#{Rails.root}/public/raven/#{level.downcase}/#{i}.PNG"), filename: "#{i}.PNG")
    ["A", "B", "C", "D", "E", "F"].each do |f_option|
      Option.create(:question_id => question.id, :option => f_option, :correct_answer => (f_option == "A") ? true : false)
    end
  end
end

def generate_input_task_questions(level, timer, user)
  set_of_ques = CSV.read("#{Rails.root}/public/input_diagramatic/#{level.downcase}/#{level.downcase}.csv")
  file_data = File.open("#{Rails.root}/public/input_diagramatic/#{level.downcase}/#{level.downcase}_rules.txt")
  set_of_rules = file_data.read
  set_of_ques.each do |ques|
    question = Question.create(:user_id => user.id, :description => "Please select the appropriate image for the given image which you think is the best match, there is only one possible solution so please look for all options carefully.", :input_rules => set_of_rules, :question => ques[0], :q_type => Question.q_types["INPUT_DIAGRAMMATIC"], :difficulty_level=> Question.difficulty_levels[level], :countdown_timer => timer)
    [*1..4].each do |f_option|
      Option.create(:question_id => question.id, :option => ques[f_option], :correct_answer => (f_option == 1) ? true : false)
    end
  end
end

["EASY", "MEDIUM", "HARD"].each do |level|
  if level == "EASY"
    generate_stenberg_questions(level, easy_questions, 5, 5, 25, 15, user)
    generate_raven_task_questions(level, 25, user)
    generate_input_task_questions(level, 25, user)
  elsif level == "MEDIUM"
    generate_stenberg_questions(level, medium_questions, 10, 10, 45, 25, user)
    generate_raven_task_questions(level, 45, user)
    generate_input_task_questions(level, 45, user)
  else
    generate_stenberg_questions(level, hard_questions, 15, 15, 60, 35, user)
    generate_raven_task_questions(level, 60, user)
    generate_input_task_questions(level, 90, user)
  end
end