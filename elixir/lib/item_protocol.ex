defprotocol ItemProtocol do
  @fallback_to_any true

  @doc """
  Updates the given item for a single day.
  """
  @spec tick(item :: struct()) :: struct()
  def tick(item)
end

defimpl ItemProtocol, for: Any do
  def tick(item) do
    %{
      item
      | quality: QualityItemProtocol.tick_quality(item),
        sell_in: SellInProtocol.tick_sell_in(item)
    }
  end
end

defprotocol SellInProtocol do
  @fallback_to_any true

  @spec tick_sell_in(item :: struct()) :: struct()
  def tick_sell_in(item)
end

defimpl SellInProtocol, for: Any do
  def tick_sell_in(item), do: item.sell_in - 1
end

defprotocol QualityItemProtocol do
  @spec tick_quality(item :: struct()) :: struct()
  def tick_quality(item)
end
