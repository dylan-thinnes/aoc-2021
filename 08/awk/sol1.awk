# Setup by splitting on spaces, teardown by printing
BEGIN { RS = " |\n" }
END { print total }

# Switch modes on |
/\|/ { mode = 5 }

# Print matching constant-segment digits
mode && /^.{2}$/ { total += 1 }
mode && /^.{4}$/ { total += 1 }
mode && /^.{3}$/ { total += 1 }
mode && /^.{7}$/ { total += 1 }

# Decrement mode & detect end of loop
mode { mode -= 1 }
