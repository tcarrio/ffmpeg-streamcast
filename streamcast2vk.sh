SERVER="$1"
STREAM_KEY="$2"
INRES="1600x1200" # input resolution
OUTRES="1280x720" # output resolution
FPS="30" # target FPS
GOP="60" # i-frame interval, should be double of FPS,
GOPMIN="30" # min i-frame interval, should be equal to fps,
THREADS="2" # max 6
CBR="4000k" # constant bitrate (should be between 1000k - 3000k)
QUALITY="fast"  # one of the many FFMPEG preset # ultrafast
AUDIO_RATE="44100"
echo "$SERVER"
echo "$STREAM_KEY"
ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
  -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
  -s $OUTRES -preset $QUALITY -tune film -acodec aac -threads $THREADS -strict normal \
  -bufsize $CBR "$SERVER/$STREAM_KEY"
