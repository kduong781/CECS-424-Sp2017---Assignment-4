
ties(cupids).
ties(happyfaces).
ties(leprechauns).
ties(reindeer).

people(mrcrow).
people(mrevans).
people(mrhurley).
people(mrspeigler).

family(daughter).
family(fatherinlaw).
family(sister).
family(uncle).

solve :-
ties(Ctie), ties(Etie), ties(Htie), ties(Stie),
all_different([Ctie, Etie, Htie, Stie]),

family(Cfam), family(Efam),
family(Hfam), family(Sfam),
all_different([Cfam, Efam, Hfam, Sfam]),

Lists = [ [mrcrow, Ctie, Cfam],
            [mrevans, Etie, Efam],
            [mrhurley, Htie, Hfam],
            [mrspeigler, Stie, Sfam] ],

\+ member([_, leprechauns, daughter], Lists),


\+ member([mrcrow, reindeer, _], Lists),
\+ member([mrcrow, happyfaces, _], Lists),


\+ member([mrspeigler, _, uncle], Lists),


\+ member([_, happyfaces, sister], Lists),


( (member([mrevans, leprechauns, _], Lists),
   member([mrspeigler, _, fatherinlaw], Lists)) ;

  (member([mrspeigler, leprechauns, _], Lists),
   member([mrevans, _, fatherinlaw], Lists)) ),

member([mrhurley, _, sister], Lists),

print(mrcrow, Ctie, Cfam),
print(mrevans, Etie, Efam),
print(mrhurley, Htie, Hfam),
print(mrspeigler, Stie, Sfam).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

print(X, Y, Z) :-
write(X), write(' got the '), write(Y),
write(' tie from his '), write(Z), write('.'), nl.
