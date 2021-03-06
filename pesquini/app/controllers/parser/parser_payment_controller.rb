# File: parser_payment_controller.rb
# Purpose: Does the parser with government contracting data.
# License: LGPL. No copyright.

# This class of the controller sets the behavior for parsing government contracting data

class Parser::ParserPaymentController < Parser::ParserController

  require 'csv'
  require 'open-uri'
  # Path to file for parser
  @@filename = 'parser_data/CEIS.csv'

  # Specify that the filter should be applied to the given controller actions
  before_filter :authorize, only: [:check_nil_ascii, 
                                    :check_date, 
                                    :import, 
                                    :build_state, 
                                    :build_sanction_type, 
                                    :build_enterprise, 
                                    :build_sanction, 
                                    :check_and_save]

  # name: index
  # explanation: This method calls a view and has no logic implemented.
  # parameters:
  # - none
  # return: none

  def index
    return
  end

  # name: check_value
  # explanation: This method recieves a string representing a payment value in 
  # and make a convertion of type.
  # parameters:
  # - text
  # return: the number in float type or nil in case of fail.

  def check_value(text)
    # receiveis a string in the format 19,470.99. Then it takes off the comma (",") and 
    # parse it to float format as 19470.99.
    begin
      return text.gsub(",","").to_f
    rescue
      return nil
    end
  end

  # name: import
  # explanation: This method recieves the data of the file.
  # parameters:
  # - none
  # return: A instance of Payment.

  def import
    #Iniciating variables
    constante = 0

    Enterprise.find_each do |enterprise|

      assert(enterprise.kind_of?(Enterprise))

      # Url where the government data is hosted
      url = 'http://compras.dados.gov.br/contratos/v1/contratos.csv?cnpj_contratada='

      begin
        data =  open(url + enterprise.cnpj).read
        csv = CSV.parse(data, :headers => true, :encoding => 'ISO-8859-1')

        create_payment(csv)
      rescue
        constante = constante + 1
      end
    end
    puts "="*50
    return puts "Quantidade de empresas sem pagamentos: ", constante
  end

  # name: import
  # explanation: This method creates a instance of Payment
  # parameters:
  # - csv
  # return: A instance of Payment.

  def create_payment(csv)
    csv.each_with_index do |row, i|
    payment = Payment.new

    assert(payment.kind_of?(Payment))

    payment.identifier = check_nil_ascii(row[0])
    payment.process_number = check_nil_ascii(row[10])
    payment.initial_value = check_value(row[16])
    payment.sign_date = check_date(row[12])
    payment.start_date = check_date(row[14])
    payment.end_date = check_date(row[15])
    payment.enterprise = enterprise
    enterprise.payments_sum = enterprise.payments_sum + p.initial_value
    check_and_save(enterprise)
    check_and_save(payment)
    
    end
  end

  # name: check_and_save
  # explanation: This method checks the data received and save it.
  # parameters:
  # - data_text
  # return: a data_text.

  def check_and_save(data_text)
    begin
      data_text.save!
      return data_text
    rescue ActiveRecord::RecordInvalid
      data_text = data_text.refresh!
      return data_text
    end
  end

end
