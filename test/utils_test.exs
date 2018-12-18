defmodule Advent.UtilsTest do
  use ExUnit.Case
  alias Advent.Utils

  test "it parses lines" do
    inputs = """
    wkzhyfdpluzeqvajtbbosngkxc
    wrzhyfdolumyqvajtbiosngkxs
    wrzhyfrulumeqvajtbiosngkxf
    wrzhyfpplumeivajtbiosrgkxc
    wrzgyfdplumeqvaltbiosngcxc
    wrzhyfdplumeqvajtbioskfksc
    urzhyfdplbmeqvrjtbiosngkxc
    wrzhnfdprumvqvajtbiosngkxc
    wrzhybdplumeqvaftbiosxgkxc
    wrzhbfdzlumeqvajtbipsngkxc
    """

    result = [
      "wkzhyfdpluzeqvajtbbosngkxc",
      "wrzhyfdolumyqvajtbiosngkxs",
      "wrzhyfrulumeqvajtbiosngkxf",
      "wrzhyfpplumeivajtbiosrgkxc",
      "wrzgyfdplumeqvaltbiosngcxc",
      "wrzhyfdplumeqvajtbioskfksc",
      "urzhyfdplbmeqvrjtbiosngkxc",
      "wrzhnfdprumvqvajtbiosngkxc",
      "wrzhybdplumeqvaftbiosxgkxc",
      "wrzhbfdzlumeqvajtbipsngkxc"
    ]

    assert Utils.parse_lines(inputs) == result
  end
end
