class HomeController < ApplicationController
  before_action :set_question, only: %i[ show_question]

  def index
  end

  def begin_test
    @user = User.create!(:name => params[:name]) 
    @user.update(:username => "P#{@user.id}")
    session[:current_user_id] = @user.id
    generate_random_questions
    first_question_id = first_question
    redirect_to show_question_path(first_question_id)
  end

  def create_user_answers
    unless params[:static_form]
      @answers = current_user.answers.find_or_create_by!(:answer => params[:option], :question_id => params[:question_id])
    end  
    next_question_id = next_question
    if next_question_id == session[:set_of_questions].last
      next_path = final_evaluation_path
    else
      next_path = show_question_path(next_question_id)
    end
    redirect_to next_path
  end

  def show_question
  end

  def final_evaluation
    @current_user = current_user
  end

  def generate_users_xlsx_file
    @current_user = current_user
    render "/home/final_evaluation.xlsx.axlsx"
  end

  private
    def set_question
      if params[:question_id] == "resting_time" || params[:question_id] == "constant_time" || params[:question_id] == "last_constant_time"
        puts "nothing"
      else  
        @question = Question.find(params[:question_id])
      end
    end

    def generate_random_questions
      total_set_of_questions_sample = []
      ["RAVEN", "STENBERG", "INPUT_DIAGRAMMATIC"].each do |type|
        ["EASY", "MEDIUM", "HARD"].each_with_index do |level, index|
          set_of_question = {}
          set_of_question[index] = select_questions_level(level, type)
          tlx_questions = select_tlx_questions(level, type)
          random_questions = set_of_question.slice(*set_of_question.keys.shuffle)
          total_set_of_questions_sample << [random_questions.values.flatten+["resting_time"]+tlx_questions+["constant_time"]]
        end
      end
      total_set_of_questions_sample = total_set_of_questions_sample.shuffle.flatten
      total_set_of_questions_sample.unshift('constant_time')
      total_set_of_questions_sample[total_set_of_questions_sample.length-1] = "last_constant_time"
      session[:set_of_questions] = total_set_of_questions_sample
    end

    def select_tlx_questions level, type
      tlx_questions = Question.where(:difficulty_level => level, :q_type => type, :is_tlx => true).pluck(:id)
      tlx_questions
    end

    def select_questions_level level, type
      level_questions = Question.where(:difficulty_level => level, :q_type => type, :is_tlx => false).pluck(:id)
      level_questions.to_a.sample(5)
    end

    def first_question
      session[:next_ques_value] = 0
      return session[:set_of_questions][session[:next_ques_value]]
    end

    def next_question
      session[:next_ques_value] += 1
      return session[:set_of_questions][session[:next_ques_value]]
    end
end
