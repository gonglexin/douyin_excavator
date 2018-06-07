defmodule DouyinExcavatorWeb.AwemeView do
  use DouyinExcavatorWeb, :view

  @download_url "https://aweme.snssdk.com/aweme/v1/play/"

  def render("index.json", %{awemes: awemes}) do
    %{data: render_many(awemes, DouyinExcavatorWeb.AwemeView, "aweme.json")}
  end

  def render("aweme.json", %{aweme: aweme}) do
    %{
      i: aweme_image_url(aweme),
      v: aweme_video_uri(aweme)
    }
  end

  def aweme_video_uri(%{"video" => %{"play_addr" => %{"uri" => uri}}}) do
    uri
  end

  def aweme_video_uri(_) do
    nil
  end

  def aweme_video_url(%{"video" => video}) do
    uri = video["play_addr"]["uri"]

    download_params = %{
      video_id: uri,
      line: 0,
      ratio: "720p",
      media_type: 4,
      vr_type: 0,
      test_cdn: "None",
      improve_bitrate: 0
    }

    "#{@download_url}?#{URI.encode_query(download_params)}"
  end

  def aweme_image_url(%{"video" => video}) do
    # todo: detect ua (chrome support webp image)
    #    urls = video["dynamic_cover"]["url_list"]
    urls = video["cover"]["url_list"]

    urls |> hd()
  end
end
