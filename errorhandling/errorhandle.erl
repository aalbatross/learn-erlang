-module(errorhandle).
-export([divide/2]).


divide(X,Y) ->
	try
		X/Y
	catch
		_:Z ->
			 io:format("Error happened ..... ~w~n",[Z])
	end.
