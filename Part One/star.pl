
object(balloon).
object(clothesline).
object(frisbee).
object(watertower).

person(msbarrada).
person(msgort).
person(mrklatu).
person(mrnikto).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

solve :-
object(Bobject), object(Gobject),
object(Kobject), object(Nobject),
all_different([Bobject, Gobject,
    Kobject, Nobject]),

day(Bday), day(Gday), day(Kday), day(Nday),
all_different([Bday, Gday, Kday, Nday]),

Lists = [ [msbarrada, Bday, Bobject],
            [msgort, Gday, Gobject],
            [mrklatu, Kday, Kobject],
            [mrnikto, Nday, Nobject]
          ],

\+ member([msgort, _, frisbee], Lists),
\+ member([mrklatu, _, balloon], Lists),
\+ member([mrklatu, _, frisbee], Lists),
earlier([mrklatu, _, _], [_, _, balloon], Lists),
earlier([_, _, frisbee], [mrklatu, _, _], Lists),

( member([msbarrada, friday, _], Lists) ;
member([_ , friday, clothesline], Lists) ),

\+ member([mrnikto, tuesday, _], Lists),

\+ member([mrklatu, _, watertower], Lists),

print(msbarrada, Bobject, Bday),
print(msgort, Gobject, Gday),
print(mrklatu, Kobject, Kday),
print(mrnikto, Nobject, Nday).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

earlier(X, _, [X | _]).
earlier(_, Y, [Y | _]) :- !, fail.
earlier(X, Y, [_ | T]) :- earlier(X, Y, T).

print(X, Y, Z) :-
    write('The unidentified sighting '), write(X), write(' saw on '), write(Z),
    write(' is a '), write(Y), write('.'), nl.
