-module(scheduler).
-export([start/2,stop/1,timer/2]).


start(Time,Fun) -> spawn(scheduler,timer,[Time,Fun]).

stop(Pid) ->
	Pid ! stop.

timer(Time,Fun) ->
	receive
		stop -> 
			void
		after Time ->
			Fun(),
			timer(Time,Fun)
	end.
