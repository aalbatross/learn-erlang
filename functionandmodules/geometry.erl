-module(geometry).
-export([area/1,test/0]).

area({rectangle,Width,Height}) 		-> Width * Height;
area({square,Side}) 			-> Side * Side;
area({circle,Radius}) 			-> 3.14 * Radius * Radius;
area({rightriangle,Base,Height}) 	-> 0.5 * Base * Height.

test() ->
	6=area({rectangle,2,3}),
	9=area({square,3}),
	3.14=area({circle,1}),
	6.0=area({rightriangle,3,4}),
	tests_passed.
