-module(clock).
-export([start/1,stop/1,tick/1]).


start(Time) -> register(clock,spawn(clock,tick,[Time])).

tick(Time) ->
	receive
		stop -> 
			io:format("clock stopped ~n")
		after Time ->
			io:format("Current time = ~w~n",[now()]),
			tick(Time)
		end.


stop(Pid) ->
	Pid ! stop.
		
			 
