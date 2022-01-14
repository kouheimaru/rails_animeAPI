class SearchController < ApplicationController
  def search
    # 入力があった場合
    require 'net/http'
    season_code = params[:season_id]
    if season_code != "" 
        # ファームからの値を取得する
        @year_code = params[:year_id]
        # urlを適切な形で取得する
        # いかのuriを選択できるようにする
        uri = URI.parse("http://api.moemoe.tokyo/anime/v1/master/#{@year_code}/#{season_code}")
        # 値を受け取る
        response = Net::HTTP.get_response(uri)
        # p response
        if season_code == 1 then
          @season = "春"
        elsif season_code == 2
          @season = "夏"
        elsif season_code == 3
          @season = "秋"
        elsif season_code == 4
          @season = "冬"
        else
          @season = ""
        end
        
        begin
          case response

          when Net::HTTPSuccess
            result = JSON.parse(response.body)
            ans = []
            result.each do |arr|
              ans << arr["title"]
            end
            @count = result.size 
            @title = ans
          end

          rescue JSON::ParserError
            @message = "入力値が不適切です"
          rescue => e
            @message = "エラーが発生しました"
        end
      end
  end
end