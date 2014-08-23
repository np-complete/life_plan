module Api
  module V1
    class ProgramsController < Api::V1::ApiController
      def index
        programs = Program.today
        title_ids = current_resource_owner.titles.where(id: programs.map(&:title_id)).map(&:id)
        channel_ids = current_resource_owner.channels.where(id: programs.map(&:channel_id)).map(&:id)
        programs = programs.select { |x| channel_ids.include?(x.channel_id) && title_ids.include?(x.title_id) }
        respond_with programs
      end
    end
  end
end
