gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/province'
require_relative '../lib/data'

class ProvinceTest < Minitest::Test

  def setup
    @asia = Province.new(sample_province_data)
    @no_producers_data = {
      name: "No producers",
      producers: [],
      demand: 30,
      price: 20
    }
    @no_producers = Province.new(@no_producers_data)
  end

  def test_province_shortfall
    assert_equal(5, @asia.shortfall)
  end

  def test_province_profit
    assert_equal(230, @asia.profit)
  end

  def test_province_production_change
    @asia.producers[0].production = 20
    assert_equal(-6, @asia.shortfall)
    assert_equal(292, @asia.profit)
  end

  def test_province_no_producers_shortfall
    assert_equal(30, @no_producers.shortfall)
  end

  def test_province_no_producers_profit
    assert_equal(0, @no_producers.profit)
  end

  def test_province_zero_demand
    @asia.demand = 0
    assert_equal(-25, @asia.shortfall)
    assert_equal(0, @asia.profit)
  end

  def test_province_negative_demand
    @asia.demand = -1
    assert_equal(-26, @asia.shortfall)
    assert_equal(-10, @asia.profit)
  end

  # NoMethodError thrown because of data type
  def test_province_empty_demand_string
    @asia.demand = ""
    assert_equal(@asia.shortfall.nan?, @asia.shortfall)
    assert_equal(@assert_equal.profit.nan?, @asia.profit)
  end

  # NoMethodError thrown because of data type
  def test_province_string_for_producers
    data = {
      name: "String producers",
      producers: "",
      demand: 30,
      price: 20
    }
    prov = Province.new(data)
    assert_equal(0, @asia.shortfall)
  end
  
end
