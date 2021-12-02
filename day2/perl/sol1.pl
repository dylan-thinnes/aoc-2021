$x=0;
$y=0;
while (<> =~ / /) {
  if    ($` eq "forward") { $x+=$'; }
  elsif ($` eq "down")    { $y+=$'; }
  elsif ($` eq "up")      { $y-=$'; }
}
print ($x*$y)
