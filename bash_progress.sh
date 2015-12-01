streaming(){
     INRES="2560x1440" # input resolution
     OUTRES="1280x720" # output resolution
     X_OFFSET="0" # moves capture area x pixels over
     Y_OFFSET="1080" # moves capture area y pixels over
     FPS="24" # target FPS
     GOP="48" # i-frame interval, should be double of FPS,
     GOPMIN="24" # min i-frame interval, should be equal to fps,
     THREADS="2" # max 6
     CBR="1500k" # constant bitrate (should be between 1000k - 3000k)
     QUALITY="fast"  # one of the many FFMPEG preset # ultrafast
     AUDIO_RATE="44100"
     STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
     SERVER="live-jfk" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list

     ffmpeg \ # final ffmpeg process
       -f alsa -i pulse \
       -f pulse -i alsa_output.usb-Skullcandy_Skullcandy_Slayer_000000000000-00.iec958-stereo.monitor \
       -f x11grab -s "$INRES" -r "$FPS" -i :0.0+$X_OFFSET,$Y_OFFSET \
       -filter_complex amerge -ac 2 -ar $AUDIO_RATE -c:a aac \
       -f flv \
       -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
       -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
}

# webcam overlay (in progress)
#       -f video4linux2 -video_size 320x200 -i /dev/video0 -vcodec h264 -filter_complex 'overlay=main_w-w:0,format=yuv420p[out]' -map '[out]' 


# original(ish) script used for basic video/audio capture
streamingbak() {
     INRES="2560x1440" # input resolution
     OUTRES="1280x720" # output resolution
     FPS="24" # target FPS
     GOP="48" # i-frame interval, should be double of FPS,
     GOPMIN="24" # min i-frame interval, should be equal to fps,
     THREADS="2" # max 6
     CBR="1000k" # constant bitrate (should be between 1000k - 3000k)
     QUALITY="fast"  # one of the many FFMPEG preset # ultrafast
     AUDIO_RATE="44100"
     STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
     SERVER="live-jfk" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list
     ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
       -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
       -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
}

