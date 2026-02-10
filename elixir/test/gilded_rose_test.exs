defmodule GildedRoseTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "Approval test 30 days" do
    expected =
      File.read!("test/ApprovalTest.ThirtyDays.verified.txt") |> String.replace("\r\n", "\n")

    result =
      capture_io(fn -> GildedRose.TextTestFixture.run(30) end) |> String.replace("\r\n", "\n")

    assert result == expected
  end

  test "aged brie increases in quality" do
    item = %Brie{sell_in: 2, quality: 0}
    updated_item = ItemProtocol.tick(item)
    assert updated_item.quality == 1
    assert updated_item.sell_in == 1
  end

  test "aged bried increases in quality by 2 after sell_in date" do
    item = %Brie{sell_in: 0, quality: 0}
    updated_item = ItemProtocol.tick(item)
    assert updated_item.quality == 2
    assert updated_item.sell_in == -1
  end

  test "aged brie quality does not exceed 50" do
    item = %Brie{sell_in: -3, quality: 49}
    updated_item = ItemProtocol.tick(item)
    assert updated_item.quality == 50
    assert updated_item.sell_in == -4

    updated_item2 = ItemProtocol.tick(updated_item)
    assert updated_item2.quality == 50
    assert updated_item2.sell_in == -5
  end

  test "aged brie sell_in decreases by 1" do
    item = %Brie{sell_in: 5, quality: 10}
    updated_item = ItemProtocol.tick(item)
    assert updated_item.sell_in == 4
  end

  test "conjured degrade in quality twice as fast as normal items" do
    item = %Conjured{sell_in: 3, quality: 6}
    updated_item = ItemProtocol.tick(item)
    assert updated_item.quality == 4
    assert updated_item.sell_in == 2

    item2 = %Conjured{sell_in: 0, quality: 6}
    updated_item2 = ItemProtocol.tick(item2)
    assert updated_item2.quality == 2
    assert updated_item2.sell_in == -1
  end
end
