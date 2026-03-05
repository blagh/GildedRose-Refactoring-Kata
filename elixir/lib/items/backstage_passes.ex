defmodule BackstagePasses do
  defstruct Item.item_fields()

  def tick_quality(item) do
    quality =
      cond do
        item.sell_in <= 0 -> 0
        item.sell_in <= 5 -> item.quality + 3
        item.sell_in <= 10 -> item.quality + 2
        item.sell_in > 10 -> item.quality + 1
      end
      |> min(50)

    quality
  end
end

defimpl QualityItemProtocol, for: BackstagePasses do
  def tick_quality(item), do: BackstagePasses.tick_quality(item)
end
