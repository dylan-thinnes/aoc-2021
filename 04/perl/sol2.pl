use strict;
use warnings;

# Load, clean up input
my $callouts = <>;
chomp $callouts;
my @callouts = split /,/, $callouts;
my @boards = <>;
for (@boards) { s/ +/ /g; s/^ //g }

my $last_winner = -1;
my $winner_callout = -1;

my @already_winners = ();
$already_winners[$_] = 0 for (0..int($#boards/6));

outer: for my $callout (@callouts) {
  $winner_callout = $callout;

  # Mark all callouts
  for (@boards) { s/(^|\W)$callout(\W)/$1a$2/g }

  # Check for any full rows
  my $ii = 0;
  for (@boards) {
    my $winner = int $ii / 6;
    $ii++;
    if (m/a a a a a/ && not $already_winners[$winner]) {
      $last_winner = $winner;
      $already_winners[$winner] = 1;
    }
  }

  # Check for any full columns
  for my $n (0..4) {
    my $m = 4 - $n;

    my @pat = @boards;
    for (@pat) {
      s/((^|\W)\w+){$n}(^|\W)a((^|\W)\w+){$m}.*\n?/x/;
      s/^[^x]+$/ /
    }
    my $pat = join "", @pat;

    while ($pat =~ /xxxxx/g) {
      my $winner = int $-[0] / 6;
      if (not $already_winners[$winner]) {
        $last_winner = $winner;
        $already_winners[$winner] = 1;
      }
    }
  }

  # Stop if everyone has won
  my $all_winners = 1;
  $all_winners = $all_winners && $_ for (@already_winners);
  last if ($all_winners);
}

print "WINNER $winner_callout $last_winner\n";

my $winner_idx = $last_winner * 6;
my $winner_board = join " ", @boards[$winner_idx..$winner_idx+5];
print "WINNER $winner_board";
my @untouched = $winner_board =~ m/\d+/g;

my $sum = 0;
$sum += $_ for (@untouched);
print $sum * $winner_callout;
print "\n";
