class SanctionTest < ActiveSupport::TestCase

  test "should not create two sanctions with same process_number" do
    sanction = Sanction.new(sanction_organ: "IML", process_number: 2)
    sanction.save
    sanction2 = Sanction.new(sanction_organ: "OML", process_number: 2)

    assert_not sanction2.save
  end

  test "should be able to create a sanction with product_number" do
    sanction3 = Sanction.new(sanction_organ: "DER", process_number: 4)

    assert sanction3.save
  end

  test "should all_years contains 25 items" do
    all_years = Sanction.all_years

    assert_equal all_years.count, 25
  end

  test "should all_years not contain 24 items" do
    all_years = Sanction.all_years

    assert_not_equal all_years.count, 24
  end

  test "should all_years not contain 26 items" do
    all_years = Sanction.all_years

    assert_not_equal all_years.count, 26
  end

  test "should all_years not contain less than 1988" do
    all_years = Sanction.all_years

    assert_equal all_years.include?(1987), false
  end

  test "should all_years not contain greater than 2015" do
    all_years = Sanction.all_years

    assert_equal all_years.include?(2016), false
  end

  test "should all_years not contain year between 1988 and 2005" do
    all_years = Sanction.all_years

    assert_equal all_years.include?(2005), true
  end

end
