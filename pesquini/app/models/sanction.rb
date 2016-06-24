# File: sanction.rb
# Purpose: Implementation of Sanction Model
# License: LGPL. No copyright.

# This class contains the representation of sanctions in the system

class Sanction < ActiveRecord::Base

  belongs_to :enterprise, counter_cache: true
  belongs_to :sanction_type
  belongs_to :state

  validates_uniqueness_of :process_number

  scope :by_year, lambda { |year| where('extract(year from initial_date) = ?', year) }

  # name: self.all_years
  # explanation: this method lists all supported years in the system
  # parameters:
  # - none
  # return: a hash containing all years
  def self.all_years
    all_years = [
                  "Todos", 1988, 1991,1992, 1995, 1996, 1997, 1998, 1999,
                  2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008,
                  2009, 2010, 2011, 2012, 2013, 2014, 2015
                ]

    return all_years
  end

  # name: refresh!
  # explanation: this method finds a sanction by its process_number
  # parameters:
  # - none
  # return: a Sanction object
  def refresh!
    single_sanction = nil

    process_number = self.process_number

    if process_number
      single_sanction = Sanction.find_by_process_number(process_number)
    else
      # nothing to do
    end

    return single_sanction
  end

  # name: self.percentual_sanction
  # explanation: this method calculates the percentual of a single sanction
  # parameters:
  # - value: integer
  # return: double
  def self.percentual_sanction(value)
    total_count_sanctions = Sanction.all.count

    percentual_sanction = 0

    if total_count_sanctions > 0
      percentual_sanction = value * 100.0
      percentual_sanction = percentual_sanction / total
    else
      # nothing to do
    end

    return percentual_sanction
  end

end
