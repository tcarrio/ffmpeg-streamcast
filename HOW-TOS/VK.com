# Adapting `bash_progress.sh` to VK.com

In order to start a stream with `ffmpeg` to VK.com you will need to retrieve a URL and key to authenticate your stream. 

From https://vk.com/video you click "New Stream", which will provide you instructions which include the URL and key for streaming. 

The modified script, streamcast2vk will allow you to pass the URL and key as parameters, with the following format:

```
streamcast2vk.sh '$url' $key
```

You need to ensure you have the the single-quotes on the URL since some of the characters will cause the command to be parsed incorrectly. 

Modify the `streamcast2vk.sh` scripts `$INRES` variable to be your resolution. It is at the moment set to 1600x1200 for a user who requested the VK.com variant.

Here is a test run of the stream
![streamcast2vk working](VK.png)