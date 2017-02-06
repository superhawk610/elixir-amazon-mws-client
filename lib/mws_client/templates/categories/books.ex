defmodule Templates.Categories.Books do
  def template_string do
    """
    <Books>
      <ProductType>
        <BooksMisc>
          <Author><%= author %></Author>
          <Binding><%= type %></Binding>
          <Language><%= lang %></Language>
        </BooksMisc>
      </ProductType>
    </Books>
    """
  end
end