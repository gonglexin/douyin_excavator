defmodule DouyinExcavatorWeb.AwemeController do
  use DouyinExcavatorWeb, :controller

  @aweme_list List.duplicate(%{
  "video" => %{
    "cover" => %{
      "uri" => "large/8839000d27daa3dc4076",
      "url_list" => ["https://p1.pstatp.com/large/8839000d27daa3dc4076.jpg",
       "https://pb3.pstatp.com/large/8839000d27daa3dc4076.jpg",
       "https://pb3.pstatp.com/large/8839000d27daa3dc4076.jpg"]
    },
    "dynamic_cover" => %{
      "uri" => "8839000d28c5d0d9eb59",
      "url_list" => ["http://p1.pstatp.com/obj/8839000d28c5d0d9eb59",
       "http://pb3.pstatp.com/obj/8839000d28c5d0d9eb59",
       "http://pb3.pstatp.com/obj/8839000d28c5d0d9eb59"]
    },
    "height" => 960,
    "play_addr" => %{
      "uri" => "v0200fbc0000bc6i4i1evctrq4cjr6kg",
      "url_list" => ["https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200fbc0000bc6i4i1evctrq4cjr6kg&line=0",
       "https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200fbc0000bc6i4i1evctrq4cjr6kg&line=1"]
    },
    "width" => 540
  }}, 35) 

  def index(conn, params) do
    query = params["query"]
    user_id = query #todo: get the user_id

    render conn, "index.html", awemes: DouyinExcavator.Crawler.get_aweme_list(user_id)
#    render conn, "index.html", awemes: @aweme_list
  end
end
