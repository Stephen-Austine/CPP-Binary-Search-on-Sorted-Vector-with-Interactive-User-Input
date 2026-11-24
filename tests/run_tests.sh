#!/usr/bin/env bash
# Black-box tests for bin/binary_search: feed stdin, compare stdout exactly.
# Usage: bash tests/run_tests.sh [path-to-binary]   (default: bin/binary_search)
BIN="${1:-bin/binary_search}"
pass=0; fail=0
PROMPT="Enter the number to search: "

check() {   # check "<name>" "<stdin>" "<expected stdout>"
  local name="$1" input="$2" expected="$3" actual
  actual="$(printf -- "$input" | timeout 5 "$BIN"; printf x)"; actual="${actual%x}"
  if [[ "$actual" == "$expected" ]]; then pass=$((pass+1)); echo "  PASS  $name"
  else fail=$((fail+1)); echo "  FAIL  $name"; echo "        expected: $(printf '%q' "$expected")"; echo "        actual  : $(printf '%q' "$actual")"; fi
}

echo "binary_search tests (array: -1 5 6 18 19 25 46 78 102 114)"
# Every element is found at its own index (positions are zero-based)
i=0
for v in -1 5 6 18 19 25 46 78 102 114; do
  check "finds $v at position $i" "$v\n" "${PROMPT}Number $v found at position $i.
"
  i=$((i+1))
done
# Values that are not present: below the range, between elements, above the range
for v in -50 0 7 20 103 200; do
  check "reports $v as not found" "$v\n" "${PROMPT}Number $v not found in the given array.
"
done

echo
echo "Known limitation (not counted as failure):"
out="$(printf 'abc' | timeout 5 "$BIN")"
if [[ "$out" == "${PROMPT}Number 0 not found in the given array." ]]; then
  echo "  CONFIRMED  non-numeric input is silently treated as 0 (see README, Known limitations)"
else
  echo "  CHANGED    non-numeric input now behaves differently: $(printf '%q' "$out")"
fi

out="$(printf '46.7\n' | timeout 5 "$BIN")"
if [[ "$out" == "${PROMPT}Number 46 found at position 6." ]]; then
  echo "  CONFIRMED  decimal input 46.7 is silently truncated to 46"
else
  echo "  CHANGED    decimal input now behaves differently: $(printf '%q' "$out")"
fi

echo
echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
