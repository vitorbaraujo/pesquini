class EnterpriseTest < ActiveSupport::TestCase

  test "should not be two enterprises with same cnpj" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")
    enterprise.save

    enterprise2 = Enterprise.new(cnpj: "1256256", corporate_name: "PepsiCola")

    assert_not enterprise2.save
  end

  test "should be enterprise with cnpj" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")

    assert enterprise.save
  end

  test "should assign sanction to enterprise" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")
    enterprise.save
    sanction = Sanction.new(sanction_organ: "IML", process_number: 2)
    sanction.enterprise_id = Enterprise.last.id
    sanction.save
    enterprise.reload
    sanction.reload

    assert_equal enterprise.sanctions_count, 1
  end

  test "should assign payments to enterprise" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")
    enterprise.save
    payment = Payment.new(identifier: "Pagamento", process_number: "Inicial")
    payment.enterprise_id = Enterprise.last.id
    payment.save
    enterprise.reload

    assert_equal enterprise.payments.count, 1
  end

  test "should new enterprise have no sanction" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")

    assert_equal enterprise.sanctions_count, 0
  end

  test "should new enterprise have no payment" do
    enterprise = Enterprise.new(cnpj: "1256256", corporate_name: "CocaCola")

    assert_equal enterprise.payments.count, 0
  end

end
