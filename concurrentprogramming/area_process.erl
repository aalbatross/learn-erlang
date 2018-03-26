-module(area_process).
-export([loop/0]).



loop() ->
	receive 
		{rectangle,Length,Width} ->
			io:format("Area of rectangle ~w~n",[Length * Width]);
		{square,Side} ->
			io:format("Area of square ~w~n",[Side*Side])
	end,
	loop().
