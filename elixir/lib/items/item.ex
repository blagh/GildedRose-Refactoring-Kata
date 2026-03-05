defmodule Item do
  @item_fields [name: nil, sell_in: nil, quality: nil]
  def item_fields, do: @item_fields
  defstruct @item_fields
end

defimpl QualityItemProtocol, for: Item do
  def tick_quality(item), do: item.quality
end

defimpl SellInProtocol, for: Item do
  def tick_sell_in(item), do: item.sell_in
end
