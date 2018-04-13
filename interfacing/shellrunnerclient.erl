-module(shellrunnerclient).
-export([exec/2,exec/3]).

exec(Command,X) ->
	X ! {self(),Command},
	receive
		{X,Command,Response} -> Response
	end.

exec(Command,Args,X) ->
	X ! {self(),Command,Args},
	receive
		{X,Command,Args,Response} -> Response
	end.
