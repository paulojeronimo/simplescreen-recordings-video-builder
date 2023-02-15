# Complete video, without the initial picture
v1_mkv=${v1_mkv:-$basename.1.mkv}

# Complete video, including the initial picture
v2_mkv=${v2_mkv:-$basename.2.mkv}
v2_mp4=${v2_mp4:-$basename.2.mp4}

# Video parts prefix
video_parts_prefix=${video_parts_prefix:-simplescreenrecorder-}

# Video parts file (used by FFmpeg)
image_png=${image_png:-$basename.png}
image_screen_time=${image_screen_time:-5}

# Video parts file
video_parts_file=${video_parts_file:-video-parts.ffmpeg}
# FFmpeg output log (for the last command only)
ff_log=ffmpeg.log
