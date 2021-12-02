with builtins;
with (import <nixpkgs> {}).lib;

rec {
    input = readFile ../input;
    words = filter (x: isString x && stringLength x > 0) (split "\n" input);
    numbers = map fromJSON words;
    sum3 = zipListsWith add (zipListsWith add numbers (tail numbers)) (tail (tail numbers));
    gt-last = zipListsWith lessThan sum3 (tail sum3);
    gt-last-count = length (filter id gt-last);
}
