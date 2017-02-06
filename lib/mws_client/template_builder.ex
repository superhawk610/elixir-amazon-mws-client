defmodule TemplateBuilder do
  require EEx

  def submit_product_feed(list, opts) do
    data = [seller_id: opts.seller_id, purge_and_replace: opts.purge_and_replace,
            products: list]
    EEx.eval_string(Templates.SubmitProductFeed.template_string, data)
  end

  def submit_price_feed(list, opts) do
    data = [seller_id: opts.seller_id, prices: list]
    EEx.eval_string(Templates.SubmitPriceFeed.template_string, data)
  end

  def submit_inventory_feed(list, opts) do
    data = [seller_id: opts.seller_id, inventory: list]
    EEx.eval_string(Templates.SubmitInventoryFeed.template_string, data)
  end

  def books_category(list) do
    EEx.eval_string(Templates.Categories.Books.template_string, list)
  end
end