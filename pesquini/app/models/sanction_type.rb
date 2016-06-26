# File: sanction_type.rb
# Purpose: Implementation of Sanction Type Model
# License: LGPL. No copyright.

# This class contains the representation of sanction types, including methods
# to show all sacntion types available and to refresh a single sanction type

class SanctionType < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :description

  # name: refresh!
  # explanation: this methods finds a sanction type by its description
  # parameters:
  # - none
  # return: a SanctionType object
  def refresh!
    single_sanction = nil

    description = self.description

    if description
      single_sanction = SanctionType.find_by_description(description)
    else
      # nothing to do
    end

    return single_sanction
  end

  # name: self.all_sanction_types
  # explanation: this method lists all types of sanctions available in the
  #   system
  # parameters:
  # - none
  # return: a hash containing all sanction types
  def self.all_sanction_types
    stantion_types =  [
                        [ "INIDONEIDADE - LEGISLAçãO ESTADUAL",
                         "Inidoneidade - Legislação Estadual" ],
                        [ "IMPEDIMENTO - LEI DO PREGãO",
                          "Impedimento - Lei do Pregão" ],
                        [ "PROIBIçãO - LEI ELEITORAL",
                          "Proibição - Lei Eleitoral" ],
                        [ "INIDONEIDADE - LEI DE LICITAçõES",
                          "Inidoneidade - Lei de Licitações" ],
                        [ "SUSPENSãO - LEI DE LICITAçõES",
                          "Suspensão - Lei de Impedimento Licitações" ],
                        [ "SUSPENSãO - LEGISLAçãO ESTADUAL",
                          "Suspensão - Legislação estadual" ],
                        [ "PROIBIçãO - LEI DE IMPROBIDADE",
                          "Proibição - Lei de improbidade" ],
                        [ "DECISãO JUDICIAL LIMINAR/CAUTELAR QUE IMPEçA
                          CONTRATAçãO",
                          "Decisão Judicial liminar" ],
                        [ "INIDONEIDADE - LEI DA ANTT E ANTAQ ",
                          "Inidoneidade - Lei da ANTT e ANTAQ" ],
                        [ "INIDONEIDADE - LEI ORGâNICA TCU",
                          "Inidoneidade - Lei Orgânica TCU" ],
                        [ "IMPEDIMENTO - LEGISLAçãO ESTADUAL",
                          "Impedimento - Legislação Estadual" ],
                        [ "SUSPENSãO E IMPEDIMENTO - LEI DE ACESSO à INFORMAçãO",
                          "Suspensão e Impedimento - Lei de Acesso à Informação" ],
                        [ "PROIBIçãO - LEI ANTITRUSTE",
                          "Proibição - Lei Antitruste" ],
                        [ "IMPEDIMENTO - LEI DO RDC",
                          "Impedimento - Lei do RDC" ],
                        [ "PROIBIçãO - LEI AMBIENTAL",
                          "Proibição - Lei Ambiental" ],
                      ]

    stantion_types
  end

end
