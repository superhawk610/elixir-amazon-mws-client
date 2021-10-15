defmodule MWSClient.Operation do
  @type t :: %__MODULE__{}

  defstruct params: %{}, path: "/", timestamp: nil, method: "POST", body: nil, headers: []
end
