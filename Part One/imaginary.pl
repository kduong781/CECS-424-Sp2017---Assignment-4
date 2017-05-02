
person(joanne).
person(lou).
person(ralph).
person(winnie).

animals(bear).
animals(moose).
animals(seal).
animals(zebra).

adventure(circus).
adventure(rockband).
adventure(spaceship).
adventure(train).

solve :-
animals(Janimal), animals(Lanimal), animals(Ranimal), animals(Wanimal),
all_different([Janimal, Lanimal, Ranimal, Wanimal]),

adventure(Jadventure), adventure(Ladventure),
adventure(Radventure), adventure(Wadventure),
all_different([Jadventure, Ladventure, Radventure, Wadventure]),

Lists = [ [joanne, Janimal, Jadventure],
            [lou, Lanimal, Ladventure],
            [ralph, Ranimal, Radventure],
            [winnie, Wanimal, Wadventure] ],


\+member([joanne, seal, spaceship], Lists),
\+member([lou, seal, spaceship], Lists),
member([_, seal, spaceship], Lists),

\+ member([joanne, bear, _],Lists),
member([joanne, _, circus], Lists),


member([winnie, zebra, _], Lists),
\+ member([_, bear, spaceship], Lists),

print(joanna, Janimal, Jadventure),
print(lou, Lanimal, Ladventure),
print(ralph, Ranimal, Radventure),
print(winnie, Wanimal, Wadventure).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

print(X, Y, Z) :-
write(X), write(' friend is '), write(Y),
write(' and went to '), write(Z), write('.'), nl.
