-module(shellrunner).
-export([start/0,run/0]).

start() -> spawn(shellrunner,run,[]).


run() ->
	receive 
		{From,Command} ->
			From ! {self(),Command,os:cmd(Command)};
		{From,Command,Args} ->
			From ! {self(),Command,Args,os:cmd(Command,Args)}
	end,
	run().
