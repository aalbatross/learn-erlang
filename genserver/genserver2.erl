-module(genserver2).
-export([start/2,rpc/2]).

start(Name,Mod) ->
	register(Name, spawn(fun() -> loop(Name,Mod,Mod:init()) end)).

rpc(Name,Request) ->
	Name ! {self(),Request},
	receive
		{Name, crash} -> exit(rpc);
		{Name, ok, Response} -> Response
	end.

loop(Name,Mod,State) ->
	receive 
		{From,Request} ->
			try Mod:handle(Request,State) of
				{Response,State1} ->
					From ! {Name, ok, Response},
					loop(Name,Mod,State1)
			catch
				_:Why ->
					log_the_error(Name,Request,Why),
					From ! {Name, crash},
					loop(Name,Mod,State)
		end
	end.	

log_the_error(Name,Request,Why) ->
	io:format("Server ~p request ~p ~n caused exception ~p~n",[Name,Request,Why]).
