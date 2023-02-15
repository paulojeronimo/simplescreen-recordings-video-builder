#!/usr/bin/env bash
: <<'REFS_IN_ASCIIDOC_FORMAT'
ffmpeg::
* https://stackoverflow.com/questions/24102336/how-can-i-place-a-still-image-before-the-first-frame-of-a-video
* https://www.bannerbear.com/blog/how-to-set-a-custom-thumbnail-for-a-video-file-using-ffmpeg/
* https://askubuntu.com/questions/110264/how-to-find-frames-per-second-of-any-video-file 
REFS_IN_ASCIIDOC_FORMAT

set -eou pipefail

cd "`dirname "$0"`"

basename=`basename "$PWD"`
ffmpeg_file=${ffmpeg_file:-join.ffmpeg}
v1_mkv=${v1_mkv:-$basename.1.mkv}
v2_mkv=${v2_mkv:-$basename.2.mkv}
v2_mp4=${v2_mp4:-$basename.2.mp4}
video_parts_prefix=${video_parts_prefix:-simplescreenrecorder-}
image_png=${image_png:-$basename.png}
image_screen_time=${image_screen_time:-5}
ff_log=ffmpeg.log

[ -f $ffmpeg_file ] && echo File $ffmpeg_file already exists. || {
  echo Generating the ffmpeg_file \($ffmpeg_file\) ...
  > $ffmpeg_file
  for v in $(ls $video_parts_prefix*)
  do
    echo "file $v" >> $ffmpeg_file
  done
} 

[ -f $v1_mkv ] && echo File $v1_mkv already exists. || {
  echo Generating the video v1_mkv \($v1_mkv\) ...
  ffmpeg -y -loglevel info -f concat -safe 0 \
    -i $ffmpeg_file -c copy $v1_mkv &> $ff_log
}

[ -f $v2_mkv ] && echo File $v2_mkv alread exists. || {
  echo Generating the video v2_mkv \($v2_mkv\) by inserting image_png \($image_png\) ...
  framerate=$(set +o pipefail; ffmpeg -i $v1_mkv 2>&1 | sed -n "s/.*, \(.*\) tbr.*/\1/p")
  ffmpeg -loop 1 -framerate $framerate -t $image_screen_time -i $image_png \
    -i $v1_mkv \
    -filter_complex '[0:0] [1:0] concat=n=2:v=1:a=0' \
    $v2_mkv &> $ff_log
}

[ -f $v2_mp4 ] && echo File $v2_mp4 already exists. || {
  echo Converting the video v2_mkv to v2_mp4 \($v2_mp4\) ...
  ffmpeg -i $v2_mkv $v2_mp4 &> $ff_log
}
