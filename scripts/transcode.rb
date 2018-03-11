#!/usr/bin/env ruby
require 'json'
# Get this list for your language with `aws s3 ls s3://vizamyl-staging/videos-in/`
raise 'Adjust for your new language, then delete this line.'

VIDS = %w{
JP_M0_P2_VIDEO
JP_M1A_P2_VIDEO
JP_M1A_P3_VIDEO
JP_M1A_P6_VIDEO
JP_M1B_P11_VIDEO
JP_M1B_P2_VIDEO
JP_M1B_P3_VIDEO
JP_M1B_P7_VIDEO
JP_M2A_P11_VIDEO
JP_M2A_P14_VIDEO
JP_M2A_P2_VIDEO
JP_M2A_P3_VIDEO
JP_M2A_P4_VIDEO
JP_M2A_P5_VIDEO
JP_M2A_P8_VIDEO
JP_M2B_P2_VIDEO
JP_M2B_P3_VIDEO
JP_M2B_P6_VIDEO
JP_M2B_P9_VIDEO
JP_M3_P11_VIDEO
JP_M3_P14_VIDEO
JP_M3_P15_VIDEO
JP_M3_P17_VIDEO
JP_M3_P19_VIDEO
JP_M3_P21_VIDEO
JP_M3_P22_VIDEO
JP_M3_P24_VIDEO
JP_M3_P25_VIDEO
JP_M3_P27_VIDEO
JP_M3_P28_VIDEO
JP_M3_P2_VIDEO
JP_M3_P31_VIDEO
JP_M3_P32_VIDEO
JP_M3_P34_VIDEO
JP_M3_P36_VIDEO
JP_M3_P38_VIDEO
JP_M3_P39_VIDEO
JP_M3_P3_VIDEO
JP_M3_P42_VIDEO
JP_M3_P43_VIDEO
JP_M3_P45_VIDEO
JP_M3_P46_VIDEO
JP_M3_P48_VIDEO
JP_M3_P51_VIDEO
JP_M3_P52_VIDEO
JP_M3_P53_VIDEO
JP_M3_P55_VIDEO
JP_M3_P58_VIDEO
JP_M3_P59_VIDEO
JP_M3_P5_VIDEO
JP_M3_P60_VIDEO
JP_M3_P6_VIDEO
JP_M3_P8_VIDEO
JP_M3_P9_VIDEO
JP_M4A_P10_VIDEO
JP_M4A_P12_VIDEO
JP_M4A_P14_VIDEO
JP_M4A_P16_VIDEO
JP_M4A_P18_VIDEO
JP_M4A_P20_VIDEO
JP_M4A_P22_VIDEO
JP_M4A_P2_VIDEO
JP_M4A_P4_VIDEO
JP_M4A_P6_VIDEO
JP_M4A_P8_VIDEO
JP_M4B_P2_CASE10_EXPLANATION_VIDEO
JP_M4B_P2_CASE11_EXPLANATION_VIDEO
JP_M4B_P2_CASE12_EXPLANATION_VIDEO
JP_M4B_P2_CASE13_EXPLANATION_VIDEO
JP_M4B_P2_CASE14_EXPLANATION_VIDEO
JP_M4B_P2_CASE15_EXPLANATION_VIDEO
JP_M4B_P2_CASE1_EXPLANATION_VIDEO
JP_M4B_P2_CASE2_EXPLANATION_VIDEO
JP_M4B_P2_CASE3_EXPLANATION_VIDEO
JP_M4B_P2_CASE4_EXPLANATION_VIDEO
JP_M4B_P2_CASE5_EXPLANATION_VIDEO
JP_M4B_P2_CASE6_EXPLANATION_VIDEO
JP_M4B_P2_CASE7_EXPLANATION_VIDEO
JP_M4B_P2_CASE8_EXPLANATION_VIDEO
JP_M4B_P2_CASE9_EXPLANATION_VIDEO
JP_M4B_P3_CASE10_EXPLANATION_VIDEO
JP_M4B_P3_CASE11_EXPLANATION_VIDEO
JP_M4B_P3_CASE12_EXPLANATION_VIDEO
JP_M4B_P3_CASE13_EXPLANATION_VIDEO
JP_M4B_P3_CASE14_EXPLANATION_VIDEO
JP_M4B_P3_CASE15_EXPLANATION_VIDEO
JP_M4B_P3_CASE1_EXPLANATION_VIDEO
JP_M4B_P3_CASE2_EXPLANATION_VIDEO
JP_M4B_P3_CASE3_EXPLANATION_VIDEO
JP_M4B_P3_CASE4_EXPLANATION_VIDEO
JP_M4B_P3_CASE5_EXPLANATION_VIDEO
JP_M4B_P3_CASE6_EXPLANATION_VIDEO
JP_M4B_P3_CASE7_EXPLANATION_VIDEO
JP_M4B_P3_CASE8_EXPLANATION_VIDEO
JP_M4B_P3_CASE9_EXPLANATION_VIDEO
}

# create-job
#   --pipeline-id <value>
#   [--input <value>]
#   [--inputs <value>]
#   [--outputs <value>]
#   [--output-key-prefix <value>]
#   [--playlists <value>]
#   [--user-metadata <value>]
#   [--job-output <value>]
#   [--cli-input-json <value>]
#   [--generate-cli-skeleton <value>]

VIDS.each do |v|
  folder = v
  pipeline = '1406736256921-3z5mxc'
  input = "Key=videos-in/#{folder}.mp4"
  output_key_prefix = "videos/#{folder}/"

  outputs = <<-JSON.delete(" \t\r\n")
  [
    {
      "Key": "hls2m",
      "PresetId": "1351620000001-200010",
      "SegmentDuration": "10"
    },
    {
      "Key": "hls15m",
      "PresetId": "1351620000001-200020",
      "SegmentDuration": "10"
    },
    {
      "Key": "hls1m",
      "PresetId": "1351620000001-200030",
      "SegmentDuration": "10"
    },
    {
      "Key": "hls600k",
      "PresetId": "1351620000001-200040",
      "SegmentDuration": "10"
    },
    {
      "Key": "hls400k",
      "PresetId": "1351620000001-200050",
      "SegmentDuration": "10"
    },
    {
      "Key": "web.mp4",
      "PresetId": "1351620000001-100070"
    },
    {
      "Key": "web.webm",
      "PresetId": "1406736363841-rmod19"
    }
  ]
  JSON

  playlists = <<-JSON.delete(" \t\r\n")
  [
    {
      "Name": "playlist",
      "Format": "HLSv3",
      "OutputKeys": ["hls2m", "hls15m", "hls1m", "hls600k", "hls400k" ]
    }
  ]
  JSON

  # Catch JSON problems early
  JSON.parse(outputs)
  JSON.parse(playlists)

  cmd = "aws elastictranscoder create-job --pipeline-id #{pipeline} --input #{input} --output-key-prefix #{output_key_prefix} --outputs '#{outputs}' --playlists '#{playlists}'"
  `#{cmd}`
end
