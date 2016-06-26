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
  # return: an Payment.

  def import
    constante = 0
    Enterprise.find_each do |e|

      # Url where the government data is hosted
      url = 'http://compras.dados.gov.br/contratos/v1/contratos.csv?cnpj_contratada='
      begin
        data =  open(url+e.cnpj).read
        csv = CSV.parse(data, :headers => true, :encoding => 'ISO-8859-1')

        csv.each_with_index do |row, i|
          p = Payment.new
          p.identifier = check_nil_ascii(row[0])
          p.process_number = check_nil_ascii(row[10])
          p.initial_value = check_value(row[16])
          p.sign_date = check_date(row[12])
          p.start_date = check_date(row[14])
          p.end_date = check_date(row[15])
          p.enterprise = e
          e.payments_sum = e.payments_sum + p.initial_value
          check_and_save(e)
          check_and_save(p)
        end
      rescue
        constante = constante +   1
      end
    end
    puts "="*50
    puts "Quantidade de empresas sem pagamentos: ", constante
  end

  # name: check_and_save
  # explanation: This method checks the data received and save it.
  # parameters:
  # - c
  # return: a C.

  def check_and_save(c)
    begin
      c.save!
      c
    rescue ActiveRecord::RecordInvalid
      c = c.refresh!
      c
    end
  end
end
