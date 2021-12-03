/down/    { aim += $2 }
/up/      { aim -= $2 }
/forward/ { x += $2; y += aim * $2 }
END       { print x * y }
