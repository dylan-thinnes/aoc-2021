with builtins;
with (import <nixpkgs> {}).lib;

rec {
    input = readFile ../input;
    words = filter (x: isString x && stringLength x > 0) (split "\n" input);
    numbers = map fromJSON words;
    gt-last = zipListsWith (x: y: x < y) numbers (tail numbers);
    gt-last-count = length (filter id gt-last);
}
