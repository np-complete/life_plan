class ProgramsController < ApplicationController
  def index
    @programs = Program.today
  end
end
