defmodule Normal do
  defstruct Item.item_fields()

  def tick_quality(item) do
    cond do
      item.sell_in <= 0 -> item.quality - 2
      item.sell_in > 0 -> item.quality - 1
    end
    |> max(0)
  end
end

defimpl QualityItemProtocol, for: Normal do
  def tick_quality(item), do: Normal.tick_quality(item)
end
