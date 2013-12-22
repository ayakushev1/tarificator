module ContentDescriptions

  module ContentList
    include ContentListStruct

    def find_content_by_name(content_name)
      CONTENTS.find{|x| x if x[:name] == content_name}
    end
    
    CONTENTS = FirstContentList::CONTENTS
    
  end
end  