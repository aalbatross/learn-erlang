-module(nameserver).
-export([start/0, loop/0]).

start() -> loop().

loop() ->
	receive
		{From,{store,Key,Value}} ->
			put(Key,Value),
			From ! {self(),stored};
		{From,lookup,Key} ->
			From ! {self(),get(Key)};
		{From,Other} ->
		        From !{self(),{error,Other}}
	end,
	loop().
