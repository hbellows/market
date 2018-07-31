class Market

  attr_reader :name,
              :vendors,
              :stocked_items

  def initialize(name)
    @name = name
    @vendors = []
    @stocked_items = Hash.new(0)
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all {|vendor| vendor.inventory.include?(item)}
  end

  def sorted_item_list
    vendor_inventory.sort.uniq
  end

  def vendor_inventory
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten
  end

  def total_inventory
    @vendors.each do |(item, quantity), vendor|
      vendor.inventory.each do |item, quantity|
        @stocked_items[item] += quantity
      end
    end
    @stocked_items
  end

end
