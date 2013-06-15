module Syobocal
  class API
    class << self
      def channels
        response = RestClient.get "http://cal.syoboi.jp/mng?Action=ShowChList"
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
        response = RestClient.get "http://cal.syoboi.jp/json?Req=ProgramByDate,TitleMedium&Start=#{Date.today.to_s}&Days=1"
        raise unless response.code == 200
        json = JSON.parse(response.body)
        json["Titles"].values
      end
    end
  end
end
