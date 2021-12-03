input =: |: =&'1';._2 (1!:1<'../input')
numbered =: input , i. 1 { $ input

done =: */@:(1&<)@:$

step   =: }. (#~"1 1 (=0.5<:+/%#)) {.
oxygen =: #. (|: input) {~ {: step^:done^:_ numbered

step   =: }. (#~"1 1 (=0.5>+/%#)) {.
co2    =: #. (|: input) {~ {: step^:done^:_ numbered

oxygen * co2
