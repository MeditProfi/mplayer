for p in $(pwd)/sherpya/*; do
  echo "- Applying $(basename $p)"
  patch -d ../.. -p1 < $p || return 1
done
