defmodule TemplateBuilder do
  def template_for("submit_product_feed", list) do
    EEx.eval_file("lib/mws_client/templates/submit_product_feed.eex", list)
  end
end