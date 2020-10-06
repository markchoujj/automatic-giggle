require 'csv'

class PeopleController < ApplicationController
  def index
  end

  def import
    file = CSV.read(params[:file].path)
    processor = CsvProcessor.new(file)
    processor.process!
    redirect_to people_path
  end
end
