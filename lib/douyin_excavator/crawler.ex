require IEx
defmodule DouyinExcavator.Crawler do
  @user_video_url "https://www.douyin.com/aweme/v1/aweme/post/"
  @favorite_video_url "https://www.douyin.com/aweme/v1/aweme/favorite/"

  @headers [
    accept:
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
    "accept-encoding": "gzip, deflate, br",
    "accept-language": "zh-CN,zh;q=0.9",
    "cache-control": "max-age=0",
    "upgrade-insecure-requests": "1",
    "user-agent":
      "Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1"
  ]

  # todo: get the signature
  def get_aweme_list(user_id, max_cursor \\ "0") do
    user_video_params = %{
      user_id: user_id,
      count: "21",
      max_cursor: max_cursor,
      aid: "1128",
#      _signature: "IqffpAAAebLdWCBbIXOsnSKn37"
      _signature: "82.EuQAAqIcMkDtGiE4oH.NvxK"
    }

    #    todo: Use proxy
    #    proxy = {"52.172.35.99", 80}
    #    case HTTPoison.get(@user_video_url, @headers, params: user_video_params, proxy: proxy) do
    case HTTPoison.get(@user_video_url, @headers, params: user_video_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"aweme_list" => aweme_list, "has_more" => has_more, "max_cursor" => max_cursor} =
          Jason.decode!(:zlib.gunzip(body))

        videos = Enum.map(aweme_list, & &1["video"]["play_addr"]["uri"])

        case has_more do
	  #          1 -> [videos | get_aweme_list(user_id, max_cursor)] |> List.flatten
	  #          _ -> videos	    
	  1 -> [aweme_list | get_aweme_list(user_id, max_cursor)] |> List.flatten |> Enum.filter(&(!is_nil(&1["video"])))
          _ -> aweme_list
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
