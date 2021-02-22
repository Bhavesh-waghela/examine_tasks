ActiveAdmin.register Question do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :input_rules, :question, :image, :q_type, :difficulty_level, :user_id, :countdown_timer, :sternberg_timer, options_attributes: [:id, :option, :correct_answer, :opt_image, :_destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:question, :q_type, :difficulty_level, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
    
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs   do
      f.input :user_id, as: :select, collection: User.all.pluck(:id)
      f.input :description, as: :froala_editor
      f.input :input_rules, as: :froala_editor
      f.input :question, as: :froala_editor
      f.input :image, as: :file
      f.input :countdown_timer, as: :select, collection: [*1..99]
      f.input :sternberg_timer, as: :select, collection: [*1..99]
      f.has_many :options, allow_destroy: true do |j|
        j.inputs :option, :input_html => {:rows => 10, :cols => 20, :maxlength => 10}
        j.input  :opt_image, as: :file
        j.inputs :correct_answer, as: :check_boxes
      end

      f.input :q_type, as: :select, collection:  Question.q_types.keys
      f.input :difficulty_level, as: :select, collection:  Question.difficulty_levels.keys
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  
end
