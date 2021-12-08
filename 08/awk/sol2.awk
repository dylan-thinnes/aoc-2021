# Setup by splitting on spaces, teardown by printing
BEGIN { RS = " |\n" }
END { print total }

# Learn digits for this row
!mode { learned[length($0)] = $0 }

# Deciphering mode
# Find matching 5-segment digits
mode && /^.{5}$/                               { find_5 = 1 }

mode && find_5 && /^.{5}$/ && $0 ~ pats["7_3"] { find_5 = 0; result += 3 }
mode && find_5 && /^.{5}$/ && $0 ~ pats["4_3"] { find_5 = 0; result += 5 }
mode && find_5                                 { find_5 = 0; result += 2 }

# Find matching 6-segment digits
mode && /^.{6}$/                               { find_6 = 1 }

mode && find_6 && /^.{6}$/ && $0 ~ pats["4_4"] { find_6 = 0; result += 9 }
mode && find_6 && /^.{6}$/ && $0 ~ pats["7_3"] { find_6 = 0; result += 0 }
mode && find_6                                 { find_6 = 0; result += 6 }

# Print matching constant-segment digits
mode &&           /^.{2}$/                     {             result += 1 }
mode &&           /^.{4}$/                     {             result += 4 }
mode &&           /^.{3}$/                     {             result += 7 }
mode &&           /^.{7}$/                     {             result += 8 }

# Decrement mode & Sum result at end of loop
mode == 1 { print result; total += result; result = 0 }
mode      { result *= 10 }
mode      { mode -= 1 }

# Switch modes on |
/\|/ {
  mode = 4
  one = learned[2]
  four = learned[4]
  seven = learned[3]
  pats["1_2"] = sprintf("^[^%s]*([%s][^%s]*){2}$", one, one, one)
  pats["4_3"] = sprintf("^[^%s]*([%s][^%s]*){3}$", four, four, four)
  pats["4_4"] = sprintf("^[^%s]*([%s][^%s]*){4}$", four, four, four)
  pats["7_3"] = sprintf("^[^%s]*([%s][^%s]*){3}$", seven, seven, seven)
}
