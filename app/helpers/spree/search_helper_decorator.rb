Spree::Core::Search::Base.class_eval do
  def retrieve_products
    @products_scope = get_base_scope
    curr_page = page || 1

    @products = @products_scope.includes([:master => [{ :prices => :sale_prices}, :default_price, :images]])  
    unless Spree::Config.show_products_without_price
      @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
    end
    @products = @products.page(curr_page).per(per_page)
  end
end