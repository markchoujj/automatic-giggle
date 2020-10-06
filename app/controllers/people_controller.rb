require 'csv'

class PeopleController < ApplicationController
  def index
    @q = Person.all.ransack(params[:q])
    @people = @q.result.includes(:locations, :affiliations).page(params[:page])
  end

  def import
    file = CSV.read(params[:file].path)
    processor = CsvProcessor.new(file)
    processor.process!
    redirect_to people_path
  end
end
