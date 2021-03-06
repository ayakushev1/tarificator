module ContentPresenters
  
  module Presenter
    include ContentPresenters::Tabs
    include ContentPresenters::Accordions
    include ContentPresenters::Layouts
    
    def show(layout_name = nil)
      layout_name ? self.send(content[:type], layout_name) : self.send(content[:type])
    end
    
    def merge_hashes (*hashes)
      return {} unless hashes
      result = {}
      class_s = ""
      style_s = ""
      hashes.each do |hash| 
        class_s += " " + hash[:class] if hash and hash[:class]
        style_s += " " + hash[:style] if hash and hash[:style]
      end
      hashes.each { |hash| result = result.merge(hash) if hash }
      result = result.merge({:class => class_s}) unless class_s == " " or class_s == ""
      result = result.merge({:style => style_s}) unless style_s == " " or style_s == ""
      result
    end
      
      
  end

end