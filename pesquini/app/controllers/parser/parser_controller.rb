class Parser::ParserController < ApplicationController

  require 'csv'
  @@filename = 'parser_data/CEIS.csv'

  def index

  end

  def check_nil_ascii(text)
    if text.include?("\u0000")
      return "Não Informado"
    else
      return text.upcase
    end
  end

  def check_date(text)
    begin
      return text.to_date
    rescue
      return nil
    end
  end

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
