use strict;
use warnings;

# Load, clean up input
my $callouts = <>;
chomp $callouts;
my @callouts = split /,/, $callouts;
<>;
my @boards = <>;
for (@boards) { s/ +/ /g; s/^ //g }

my $winner = -1;
my $winner_callout = -1;

outer: for my $callout (@callouts) {
  $winner_callout = $callout;

  # Mark all callouts
  for (@boards) { s/(^|\W)$callout(\W)/$1a$2/g }

  # Check for any full rows
  $ii = 0;
  for (@boards) {
    $winner = int $ii / 6;
    last outer if (m/a a a a a/);
    $ii++;
  }

  # Check for any full columns
  for my $n (0..4) {
    my $m = 4 - $n;

    my @pat = @boards;
    for (@pat) {
      s/((^|\W)\w+){$n}(^|\W)a((^|\W)\w+){$m}.*\n?/x/;
      s/^[^x]+$/ /
    }

    if ((join "", @pat) =~ m/xxxxx/) {
      $winner = int $-[0] / 6;
      last outer;
    }
  }
}

print "WINNER $winner_callout $winner\n";

my $winner_idx = $winner * 6;
my $winner_board = join " ", @boards[$winner_idx..$winner_idx+5];
my @untouched = $winner_board =~ m/\d+/g;

my $sum = 0;
$sum += $_ for (@untouched);
print $sum * $winner_callout;
print "\n";
