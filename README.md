# ffmpeg-streamcast
Qt-based ffmpeg-wrapper for streaming services with video/audio/webcam features

# For the future
There is great documentation available for ffmpeg streaming at <a href="https://trac.ffmpeg.org/wiki/StreamingGuide">ffmpeg's website</a>. This will be useful for my project or anyone else who wants to try streaming on Linux. 
An issue seen so far is that display devices are handled differently when launching with a desktop manager (like GDM). Currently on Arch with gnome-desktop, but no gdm, and enabling and starting through gdm will cause the previous script to fail. Issues to investigate to allow this to work across the many different options available on Linux. 
