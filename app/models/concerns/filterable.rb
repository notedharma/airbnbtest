# Call scopes directly from your URL params:
#
#     @products = Product.filter(params.slice(:status, :location, :starts_with))
module Filterable
  extend ActiveSupport::Concern

  module ClassMethods

    # Call the class methods with the same name as the keys in <tt>filtering_params</tt>
    # with their associated values. Most useful for calling named scopes from
    # URL params. Make sure you don't pass stuff directly from the web without
    # whitelisting only the params you care about first!
    def filter(filtering_params)
      results = self.where(nil) # create an anonymous scope
      filtering_params.each do |key, value|
        case key
        when "min_price"
          if value.to_i > 0
          results = results.where("#{:price_night} > 200")


        end
        when "max_price"
          if value.to_i > 0
          results = results.where("#{:price_night} < #{value.to_i}")
        end
        else
          results = results.where("#{key} ILIKE '%#{value}%'")
        end



      end
      results
    end
  end
end
