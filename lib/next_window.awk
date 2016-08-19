BEGIN {
  FS = ":"
}

END {
  print $1 + 1
}
