# The complete video without the initial picture
v1_mkv=${v1_mkv:-$basename.1.mkv}

# The complete video including the initial picture
v2_mkv=${v2_mkv:-$basename.mkv}
v2_mp4=${v2_mp4:-$basename.mp4}

# The video parts prefix
video_parts_prefix=${video_parts_prefix:-simplescreenrecorder-}

# The image file that will be inserted at the start of the video
image_png=${image_png:-$basename.png}

# The amount of time that the video will show the image file
image_screen_time=${image_screen_time:-1}

# The video parts file
video_parts_file=${video_parts_file:-video-parts.ffmpeg}

# The generated FFmpeg output log (for the last command only)
ff_log=ffmpeg.log
