defmodule Brie do
  defstruct Item.item_fields()

  def tick_quality(item) do
    quality =
      cond do
        item.sell_in <= 0 -> item.quality + 2
        item.sell_in > 0 -> item.quality + 1
      end
      |> min(50)

    quality
  end
end

defimpl QualityItemProtocol, for: Brie do
  def tick_quality(item), do: Brie.tick_quality(item)
end
