#! /bin/bash
# Thanks to:
# https://gist.github.com/hfossli/6003302
# http://stackoverflow.com/questions/2553448/encode-video-is-reverse
# http://superuser.com/questions/533695/how-can-i-convert-a-series-of-png-images-to-a-video-for-youtube
# https://sites.google.com/site/linuxencoding/ffmpeg-tips
tmp=`mktemp -d -t eniv`
mkdir -p $tmp

cd $tmp
curl $1 > vine.mp4

mkdir frames
mkdir invertedframes

# avconv -i vine.mp4 frames/%d.png
ffmpeg -ss 0 -i vine.mp4 frames/%d.png


# Inverse files
images=`ls frames/*.png | wc -l`

i=1
factor=0
while [ $factor -lt $images ]; do
    new_name=$((images-factor))
    mv frames/$i.png invertedframes/$new_name.png
    let factor=factor+1
    let i=i+1
done

# Reverse MONO audio
# avconv -i vine.mp4 -ac 1 -f sox - | sox -p reversed.wav reverse
ffmpeg -i vine.mp4 -ac 1 -f sox - | sox -p reversed.wav reverse

# Merge frames into file and pipe it to the audo+video encoder
# avconv -r 29.97 -i invertedframes/%d.png -vcodec libx264 -pix_fmt yuv420p -f image2pipe - -i reversed.wav -vcodec libx264 -pix_fmt yuv420p -y -f mp4 $2 > /dev/null 
ffmpeg -r 29.97 -i invertedframes/%d.png -vcodec libx264 -pix_fmt yuv420p -f image2pipe - -i reversed.wav -vcodec libx264 -pix_fmt yuv420p -y -f mp4 $2 > /dev/null

rm -rf $tmp

