class Market

  attr_reader :name,
              :vendors,
              :stocked_items

  def initialize(name)
    @name = name
    @vendors = []
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
    @vendors.inject(Hash.new(0)) do |stock, (vendor, quantity)|
      find_inventory(vendor, quantity, stock)
      stock
    end
  end

  def find_inventory(vendor, quantity, stock)
    vendor.inventory.each do |item, quantity|
      stock[item] += quantity
    end
  end

  def sell(item, quantity)
    sellers = vendors_that_sell(item)
    sellers.map do |vendor|
      vendor.inventory.map do |item, amount|
        require "pry"; binding.pry
        if available(item, amount)
          total_inventory[item] -= amount
        end
      end
    end
  end

  def available?(item, quantity)
    if total_inventory[item] < quantity
      false
    else
      true
    end
  end

end
