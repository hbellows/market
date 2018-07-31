require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_a_vendor_starts_with_no_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal ({}), vendor.inventory
  end

  def test_a_vendor_can_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock('Peaches')
  end

  def test_a_vendor_can_stock_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    vendor.stock("Peaches", 30)
    assert_equal 30, vendor.check_stock("Peaches")

    vendor.stock("Peaches", 25)
    assert_equal 55, vendor.check_stock("Peaches")

    vendor.stock("Tomatoes", 12)
    assert_equal 12, vendor.check_stock("Tomatoes")
    assert_equal ({"Peaches" => 55, "Tomatoes" => 12}), vendor.inventory
  end

end
