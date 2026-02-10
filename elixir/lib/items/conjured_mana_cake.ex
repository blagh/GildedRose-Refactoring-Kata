defmodule Conjured do
  defstruct Item.item_fields()

  def tick_quality(item) do
    cond do
      item.sell_in <= 0 -> item.quality - 4
      item.sell_in > 0 -> item.quality - 2
    end
    |> max(0)
  end
end

defimpl QualityItemProtocol, for: Conjured do
  def tick_quality(item), do: Conjured.tick_quality(item)
end
