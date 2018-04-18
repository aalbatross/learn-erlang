-module(eventhandler).
-compile(export_all).


start() -> register(?MODULE, spawn(eventhandler,loop,[dict:new()])).

add_handler(HandlerName,Function) ->
	?MODULE ! {self(),add,HandlerName,Function},
	receive
		Response -> Response
	end.

remove_handler(HandlerName) ->
	?MODULE ! {self(),remove,HandlerName},
        receive
                Response -> Response
        end.

generate_event(X) ->
	?MODULE ! {self(), apply,X},
	receive
		Response -> Response
	end.

loop(State) ->
	receive
		{From, add, HandlerName, Function} ->
			case dict:find(HandlerName,State) of
				{ok,_} -> 
					From ! {self(),already_registered},
					loop(State);
				error -> 
					State1=dict:append(HandlerName,Function,State),
					From ! {self(),ok},
					loop(State1)
			end;
		{From, remove,HandlerName} ->
			case dict:find(HandlerName,State) of
                                {ok,_} -> 
                                        State1 =dict:erase(HandlerName,State),
					From ! {self(),ok},
                                        loop(State1);
                                error -> 
                                        From ! {self(),cannot_remove},
                                        loop(State)
                        end;
		{From, apply, {event,HandlerName, Request}} ->
			case dict:find(HandlerName,State) of
                                {ok,[F]} ->
					F(Request),
                                        From ! {self(),ok},
                                        loop(State);
                                error ->
                                        From ! {self(),no_handler_found},
                                        loop(State)
                        end
	end.

