/down/    { y += $2 }
/up/      { y -= $2 }
/forward/ { x += $2 }
END       { print x * y }
