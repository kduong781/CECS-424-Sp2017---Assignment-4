:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

i_am_at(bedroom).

path(kitchen, n, bedroom).
path(bedroom, s, kitchen).
path(bathroom, e, bedroom).
path(bedroom, w, bathroom) :-
  holding(key).
path(bedroom, w, bathroom) :-
  write('Bathroom is locked. You need a key.'), nl,
  fail.

path(bedroom, e, exitroom) :-
  holding(medicine),
  holding(flashlight),
  holding(battery),
  holding(bulb),
  write('You win! You have found everything!'), nl,
  finish.
path(bedroom, e, exitroom) :-
  write('You have collapsed. You need one medicine.'), nl,
  die.



at(flashlight, bathroom).
at(battery, bedroom).
at(box, bedroom).
at(bulb, kitchen).
at(key, bedroom).

/* These rules describe how to pick up an object. */

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

break(box) :-
  holding(box),
  write('You have found medicine. You might need this to not collapse.'),
  assert(holding(medicine)).

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.

use(flashlight) :-
  holding(flashlight),
  holding(battery),
  holding(bulb),
  write('The flashlight is on!'), nl.

use(flashlight) :-
  write('It looks like you need a bulb and a couple of batteries to use this.'), nl,
  fail.
/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.'), nl.


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).

i :-
  listing(holding).


/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('i                  -- to see what you are holding'), nl,
        write('break              -- break an object'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        write('You have entered the bedroom. The kitchen is south of you. The bathroom is west of you. The exit is east of you. You might be able to break the box.'),
        nl.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(someplace) :- write('You are someplace.'), nl.

describe(bedroom) :-
  write('You have entered the bedroom. The kitchen is south of you. The bathroom is west of you. The exit is east of you. You might be able to break the box.'), nl.

describe(kitchen) :-
  write('You have entered the kitchen. The bedroom is north of you.'), nl.

describe(bathroom) :-
  write('You have entered the bathroom. The bedroom is east of you.'), nl.
