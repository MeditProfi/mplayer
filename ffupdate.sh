#! /bin/sh

_checkout_rev=

show_help(){
cat << EOF
Usage: $0 [OPTIONS]...

Configuration:
  -h, --help                    display this help and exit
  --checkout=[GIT REVISION]     checkout specific git revision

EOF
exit 0
} #show_help()


for ac_option do
  case "$ac_option" in
  --help|-help|-h)
    show_help
    ;;
  --checkout=*)
    _checkout_rev=$(echo $ac_option | cut -d '=' -f 2)
    ;;
  *)
    echo "Unknown parameter: $ac_option"
    exit 1
    ;;

  esac
done

if [ -z $_checkout_rev ] ; then
  cd ffmpeg
  git checkout master
  git pull
  detached=0
else
  cd ffmpeg
  git checkout $_checkout_rev
  detached=1
fi

ffmpeg_version=$(sh version.sh)
ffmpeg_gitfull=$(git rev-parse HEAD)
ffmpeg_gitshort=$(git rev-parse --short HEAD)
checkout_date=$(date)
commit_date=$(git show -s --format=%cd)
commit_title=$(git show -s --format=%s)

test $ffmpeg_version || ffmpeg_version=UNKNOWN
test $ffmpeg_gitfull || ffmpeg_gitfull=UNKNOWN
test $ffmpeg_gitshort || ffmpeg_gitshort=UNKNOWN
test "$commit_date" || commit_date=UNKNOWN
test "$commit_title" || commit_title=UNKNOWN

cat <<EOF > ../dev/ffmpeg_version.h
#define FFMPEG_VERSION "${ffmpeg_version}"
#define FFMPEG_GIT_FULL "${ffmpeg_gitfull}"
#define FFMPEG_GIT_SHORT "${ffmpeg_gitshort}"

#define CHECKOUT_DATE "${checkout_date}"
#define LAST_COMMIT_DATE "${commit_date}"
#define LAST_COMMIT_TITLE "${commit_title}"
#define DETACHED_HEAD "${detached}"
EOF
