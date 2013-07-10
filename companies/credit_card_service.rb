class CreditCardService

  def self.valid_credit_card?(creditcard)
    sleep 7 #maybe some network delay to creditcard service
    creditcard[-1,1].to_i.even?
  end
end
