-module(geometrytest).
-export([test/0]).

test() ->
	230=geometry:area({rectangle,23,10}),
	100=geometry:area({square,10}),
	3.14=geometry:area({circle,1}),
	tests_worked.
