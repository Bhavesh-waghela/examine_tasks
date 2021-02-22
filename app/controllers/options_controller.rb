class OptionsController < InheritedResources::Base

  private

    def option_params
      params.require(:option).permit(:option, :question_id)
    end

end
