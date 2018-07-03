defmodule DouyinExcavator.CrawlerTest do
  use ExUnit.Case

  alias DouyinExcavator.Crawler

  test "get_user_id with user id" do
    assert Crawler.get_user_id("1234") == "1234"
  end

  test "get_user_id with user share link" do
    assert Crawler.get_user_id("https://www.douyin.com/share/user/1234/?share_type=link") == "1234"
  end

  test "get_user_id with user share encrypted link" do
    assert Crawler.get_user_id("http://v.douyin.com/J6HgrE/?from=singlemessage") == "80343351806"
  end
end
