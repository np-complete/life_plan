module Syobocal
  class API
    class << self
      def ua
        %{A Life Planner; https://life-plan.np-complete-doj.in}
      end

      def channels
        response = RestClient.get "http://cal.syoboi.jp/mng?Action=ShowChList", user_agent: ua
        raise unless response.code == 200
        nokogiri = Nokogiri::HTML(response)
        nokogiri.css("table.tframe.output:eq(2) tr").map do |x|
          channel = x.css("td").map(&:text)
          {
            group_name: channel[1],
            group_id: channel[2].to_i,
            name: channel[3],
            channel_id: channel[4].to_i
          }
        end.select {|x| x[:group_name].present? }
      end

      def programs
        query = { :Req => "ProgramByDate,TitleMedium,SubTitles",
          :Start => Date.today.to_s,
          :Days => 1 }.to_query
        response = RestClient.get "http://cal.syoboi.jp/json?#{query}", user_agent: ua
        raise unless response.code == 200
        json = JSON.parse(response.body)

        subtitles = json["SubTitles"]
        titles = json["Titles"].map(&:last).map do |title|
          title_hash = {
            id: title["TID"].to_i,
            name: title["Title"],
            kana: title["TitleYomi"]
          }
          unless title["FirstYear"].blank? || title["FirstMonth"].blank?
            title_hash[:started_at] = DateTime.new(title["FirstYear"].to_i, title["FirstMonth"].to_i, 1).beginning_of_month
          end
          unless title["FirstEndYear"].blank? || title["FirstEndMonth"].blank?
            title_hash[:finished_at] =DateTime.new(title["FirstEndYear"].to_i, title["FirstEndMonth"].to_i, 1).end_of_month
          end
          OpenStruct.new(title_hash)
        end

        stored_titles = Title.where(id: titles.map(&:id)).map{|x| [x.id, x]}

        titles.each do |title|
          stored_title = stored_titles.assoc(title.id).try(:last)
          unless stored_title
            Title.create(title.to_h)
          else
            unless title.to_h.all? { |key, value| stored_title.send(key) == value }
              stored_title.update_attributes(title.to_h)
            end
          end
        end

        programs = json["Programs"].map(&:last).map do |program|
          program_hash = {
            id: program["PID"].to_i,
            title_id: program["TID"].to_i,
            no: program["Count"].to_i,
            channel_id: program["ChID"].to_i,
            start_at: Time.at(program["StTime"].to_i)
          }
          subtitle = subtitles.try(:[], program_hash[:title_id].to_s).try(:[], program_hash[:no].to_s)
          program_hash[:subtitle] = subtitle unless subtitle.blank?
          OpenStruct.new(program_hash)
        end
      end
    end
  end
end
