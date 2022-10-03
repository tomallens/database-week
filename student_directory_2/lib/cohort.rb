require 'student'

class Cohort
  attr_accessor :id, :name, :starting_date, :students
  #:students added because joins

  def initialize
    @students = []
  end
end