# File: paerser_cei_controller.rb
# Purpose: Implementation of parser cei controller.
# License: LGPL. No copyright.

# This class of the controller sets the behavior for parsing enterprise, 
# state and sanctions.

class Parser::ParserCeiController < Parser::ParserController

  require 'csv'

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

  # name: check_nil_ascii
  # explanation: This method checks if the field is empty.
  # parameters:
  # - text
  # return: Text in upcase or the message "Não Informado".

  def check_nil_ascii(text)
    if text.include?("\u0000")
      return "Não Informado"
    else
      return text.upcase
    end
  end

  # name: check_date
  # explanation: This method converts text in the format of date.
  # parameters:
  # - text
  # return: the date format of text.

  def check_date(text)
    begin
      return text.to_date
    rescue
      return nil
    end
  end

  # name: import
  # explanation: This method import datas of the file.
  # parameters:
  # - none
  # return: a hash with the read data.

  def import
    #Iniciating variables
    xd = 0
    CSV.foreach(@@filename, :headers => true, :col_sep => "\t",
                :encoding => 'ISO-8859-1') do |row|
      data = row.to_hash
      unless data["Tipo de Pessoa"].match("J|j").nil?
        sanction_type = build_sanction_type(data)
        state = build_state(data)
        enterprise = build_enterprise(data)
        build_sanction(data, sanction_type, state, enterprise)
      end
    end
  end

  # name: build_state
  # explanation: This method saves a instance of State.
  # parameters:
  # - row_data
  # return: A instance of State.

  def build_state(row_data)
    state = State.new

    assert(state.kind_of?(State))

    state.abbreviation = check_nil_ascii(row_data["UF Órgão Sancionador"])

    return check_and_save(state)
  end

  # name: build_sanction_type
  # explanation: This method saves a instance of SanctionType.
  # parameters:
  # - row_data
  # return: A instance of SanctionType.

  def build_sanction_type(row_data)
    sanction = SanctionType.new

    assert(sanction.kind_of?(Sanction))

    sanction.description = check_nil_ascii(row_data["Tipo Sanção"])

    return check_and_save(sanction)
  end

  # name: build_enterprise
  # explanation: This method saves a instance of Enterprise.
  # parameters:
  # - row_data
  # return: A instance of Enterprise.

  def build_enterprise(row_data)
    enterprise = Enterprise.new

    assert(enterprise.kind_of?(Enterprise))

    enterprise.cnpj = row_data["CPF ou CNPJ do Sancionado"]
    enterprise.corporate_name = check_nil_ascii(row_data["Razão Social - Cadastro Receita"])

    return check_and_save(enterprise)
  end

  # name: build_sanction
  # explanation: This method saves a instance of Sanction.
  # parameters:
  # - row_data
  # return: A instance of Sanction.

  def build_sanction(row_data, sanction_type, state, enterprise)
    sanction = Sanction.new

    assert(sanction.kind_of?(Sanction))

    create_sanction(sanction)

    return check_and_save(sanction)
  end

  # name: create_sanction
  # explanation: This method creates a instance of Sanction.
  # parameters:
  # - sanction
  # return: A instance of Sanction.

  def create_sanction(sanction)
    sanction.initial_date = check_date(row_data["Data Início Sanção"])
    sanction.final_date = check_date(row_data["Data Final Sanção"])
    sanction.process_number = check_nil_ascii(row_data["Número do processo"])
    sanction.enterprise_id = enterprise.id
    sanction.sanction_type_id = sanction_type.id
    sanction.sanction_organ = check_nil_ascii(row_data["Órgão Sancionador"])
    sanction.state_id = state.id

    return sanction
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
