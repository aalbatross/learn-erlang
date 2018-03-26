-module(areaserver).
-export([start/0,loop/0]).


start() -> spawn(areaserver,loop,[]).

loop() ->
	receive 
		{From, {rectangle,Width,Height}} ->
			From !{self(),Width* Height};
		{From, {square, Side}} ->
			From !{self(), Side*Side};
		{From, Other} ->
			From !{self(), {error,Other}}
		end,
	loop().
