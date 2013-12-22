module FiltrDescriptions
  module FiltrList
    include FiltrListStruct

    def find_filtr_param(controller_name, action_name, model_name)
      filtr_key = FiltrKey.new(controller_name, action_name, model_name)
      FILTR_PARAM.find{|x| x if x[:key]==filtr_key}
    end
      
    FILTR_PARAM = FirstFiltrList::FILTR_PARAM + 
                  FiltrDescriptions::Authority::SearchingUserAuthorities::FILTR_PARAM +
                  FiltrDescriptions::Authority::CheckingUrlAccessAuthorities::FILTR_PARAM 

  end
end