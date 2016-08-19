BEGIN {
  FS = ":"
}

/attached/ {
  print $1
}
