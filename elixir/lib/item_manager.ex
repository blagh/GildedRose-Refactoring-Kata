defmodule ItemManager do
  @aged_brie "Aged Brie"
  @sulfuras "Sulfuras, Hand of Ragnaros"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"

  @default_module Normal
  @modules %{
    @aged_brie => Brie,
    @sulfuras => Item,
    @backstage_passes => BackstagePasses,
    @conjured => Conjured
  }

  def get_module(item) do
    Map.get(@modules, item.name, @default_module)
  end

  def build_items(items) do
    Enum.map(items, fn item ->
      module = get_module(item)
      struct(module, Map.from_struct(item))
    end)
  end

  def tick(items) do
    Enum.map(items, fn item ->
      ItemProtocol.tick(item)
    end)
  end
end
