BEGIN {
  FS = ":"
}

END {
  print $1
}
