defmodule TemplateBuilder do
  def submit_product_feed(list, opts) do
    data = [seller_id: opts.seller_id, purge_and_replace: opts.purge_and_replace,
            products: list]
    EEx.eval_file("lib/mws_client/templates/submit_product_feed.eex", data)
  end

  def submit_price_feed(list, opts) do
    data = [seller_id: opts.seller_id, prices: list]
    EEx.eval_file("lib/mws_client/templates/submit_pricing_feed.eex", data)
  end

  def submit_inventory_feed(list, opts) do
    data = [seller_id: opts.seller_id, inventory: list]
    EEx.eval_file("lib/mws_client/templates/submit_inventory_feed.eex", data)
  end
end