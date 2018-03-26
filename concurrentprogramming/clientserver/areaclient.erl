-module(areaclient).
-export([get_area/2]).


get_area(Pid,Request) ->
	Pid ! {self(),Request},
	receive
		{Pid,Response} ->
			Response
	end.
			
		
