$aim=0;
$x=0;
$y=0;
while (<> =~ / /) {
  if    ($` eq "forward") { $x+=$'; $y+=$aim*$' }
  elsif ($` eq "down")    { $aim+=$'; }
  elsif ($` eq "up")      { $aim-=$'; }
}
print ($x*$y)
