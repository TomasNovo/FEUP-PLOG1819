:- consult('utilities.pl'), use_module(library(lists)).


display_gameStart :-
	write('Welcome to Knights Line !'), nl, nl.

display_menu :-
	write('Choose the mode you want to play :'), nl,
	write('1 - Player vs Player '), nl,
	write('2 - Player vs Computer '), nl,
	write('3 - Watch Computer vs Computer '), nl,
	write('4 - Credits '), nl,
	write('5 - Exit'),nl.

pc_difficulty_read(Y) :-
	Y = 0 ->
		write('Difficulty Medium setted !'),nl;
	Y \= 0 ->
		write('Difficulty Hard setted !').

gameOptions(X) :-
	X = 1 -> (
							write('You selected Player vs Player game !'),nl, nl,
							write('Have a nice game ! '), nl, nl,
							make_game(_) );
	X \= 1 -> (X = 2 -> (write('You selected Player vs Computer game !'),
										 nl, nl, write('Please enter PC difficulty (0 for medium, 1 for hard)'),
										 nl, write('Input: '), read(Y),
										 pc_difficulty_read(Y));
						X \= 2 -> (X = 3 -> (write('Option 3'));
											 X \= 3 -> (X = 4 -> (write('Game developed by : '), nl,
																					write('- Joao Pedro Viveiros Franco'), nl,
																					write('- Tomas Nuno Fernandes Novo'), nl,nl);
																X \= 4 -> (X = 5 -> (write('Thank you, bye !'),nl,true);
																					 X \= 5	-> (write('You have picked an invalid option !'),
																					 						nl, nl,
																											write('Please, input again !'),
																											nl,nl,
																											kl))))).

kl :-
	display_gameStart,
	display_menu, nl,
	write('Input: '),
	read(A),
	gameOptions(A).


make_game(C) :-
	printInitial,nl,nl,
	write('Where do you wanna go ? A or B ?'),
	read(C).

makeMove([H|T], X1, Y1, X2, Y2, N2, X):-
	length([H|T], Bl),
	length(H, Ll),
	X1 > -1, X1 < Ll, X2 > -1, X2 < Ll, Y1 > -1, Y1 < Bl, Y2 > -1, Y2 < Bl,
	getPiece([H|T], 0, X1, Y1, Piece),
	nth0(0, Piece, N1),
	nth0(1, Piece, Colour),
	nth0(Y1, [H|T], Line),
	N is N1-N2,

	N > 0, N2 > 0,

	replace(Line, X1, [N, Colour], L),
	replace([H|T], Y1, L, Foo),

	nth0(Y2, [H|T], Line2),
	replace(Line2, X2, [N2, Colour], L2),
	replace(Foo, Y2, L2, X), !.

getPiece([], _, _, _, _).
getPiece([H|T], I, X, Y, Piece) :-
	I = Y -> nth0(X, H, Piece);
	I1 is I+1,
	getPiece(T, I1, X, Y, Piece).


addVerticalLines([], []).
addVerticalLines([H|T], [H2|Tail]):-
	addHead(H, [], Z),
	addTail(Z, [], H2),
	addVerticalLines(T, Tail).


addHorizontalLines([H|T], Y) :-
	append([H|T], [], X),
	length(H, Hl),
	createLine(W, Hl),
	addHead(X, W, Z),
	addTail(Z, W, Y).