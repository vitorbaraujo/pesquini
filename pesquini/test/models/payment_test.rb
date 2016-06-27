class PaymentTest < ActiveSupport::TestCase

  test "should not be able to create two payments with same process_number" do
    payment = Payment.new(identifier: "Pagamento", process_number: "Inicial")
    payment.save
    payment2 = Payment.new(identifier: "Pagamento2", process_number: "Inicial")

    assert_not payment2.save
  end

  test "should be able to create a payment" do
    payment = Payment.new(identifier: "Pagamento", process_number: "OutroInicial")

    assert payment.save
  end

end
