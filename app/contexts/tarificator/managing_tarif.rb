class Tarificator::ManagingTarif < BaseContext

  def initialize user, controller
    super    
    self.extend Presenter
    self.extend Helper
  end
  
  def show
    in_context do
      @filtrs["tarif"] = Filtrs::Filtr.new(c, "tarif")
      @filtrs["tarif_characteristics"] = Filtrs::Filtr.new(c, "tarif_characteristics")
      @filtrs["tarif_characteristic_values"] = Filtrs::Filtr.new(c, "tarif_characteristic_values")
       
      standart_respond_to(:showing)
    end
  end
  
  def index
    in_context do
#      copy_tarifs_from_tarifer_to_tarificator
      
      
      @filtrs["tarif_searching"] = Filtrs::Filtr.new(c, "tarif_searching")      
      @filtrs["tarifs"] = Filtrs::Filtr.new(c, "tarifs")
      
      standart_respond_to(:indexing)
    end
  end
  
  module Helper
    def copy_tarifs_from_tarifer_to_tarificator
      Tarifer::Tarif.all.each do |t|
        Tarificator::Tarif.create(
        :id => t.id,
        :name => t.name,
        :description => t.description,
        :region_id => get_tarificator_category_from_tarifer_category(t.region_id),
        :operator_id => get_tarificator_category_from_tarifer_category(t.operator_id),
        :privacy_id => get_tarificator_category_from_tarifer_category(t.privacy_id),
        :standard_service_id => 50
        )
      end
    end
    
    def get_tarificator_category_from_tarifer_category(category_id)
      category = Tarifer::Category.find_by_id(category_id)
      if category
        category_name = category.name
        category_type_id = get_tarificator_category_type_from_tarifer_category_type(category.category_type_id)
        if category_type_id == 1
          if category_name == 'Украина'
            Tarificator::Category.find_or_add_category_by_name(category_name, category_type_id, 1500)
          else
            Tarificator::Category.find_or_add_category_by_name(category_name, category_type_id, 1100)
          end
        else
          Tarificator::Category.find_or_add_category_by_name(category_name, category_type_id)
        end
      else
        nil
      end
    end

    def get_tarificator_category_type_from_tarifer_category_type(category_type_id)
      category_type = Tarifer::CategoryType.find_by_id(category_type_id)
      if category_type
        Tarificator::CategoryType.find_or_add_category_type_by_name(category_type.name)
      else
        nil
      end        
    end
    
  end
    
  module Presenter

    def showing
      @filtrs["tarif"].show +
      @filtrs["tarif_characteristics"].show +
      @filtrs["tarif_characteristic_values"].show
    end

    def indexing
      @managing_tarif_search =Contents::Content.new(self, :managing_tarif_search1)

#      c_tag(:div, get_tarificator_category_from_tarifer_category(13)) +
#      c_tag(:div, @filtrs["tarifs"].model_raws_to_show.to_sql.html_safe) +
      @managing_tarif_search.show(:main_accordion_layout) +
      @filtrs["tarifs"].show
    end
  end
end