for p in $(pwd)/redxii/*.diff; do
  echo "- Applying $(basename $p)"
  patch -d ../.. -p0 < $p || return 1
done
