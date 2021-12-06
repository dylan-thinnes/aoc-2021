my @fish = (0, 0, 0, 0, 0, 0, 0, 0, 0);
$fish[$_]++ for (split ",", <>);

for (1..80) {
  push @fish, shift @fish;
  $fish[6] += $fish[8];
}

my $total = 0;
$total += $_ for (@fish);
print "$total\n";
