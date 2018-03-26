-module(b).
-export([start/1]).


start(Tag) -> spawn(loop(Tag)).

loop(Tag) ->
	sleep(),
	code:purge(a),
	compile:file(a),
	code:load_file(a),
	V=a:start(),
	io:fwrite("Tag: ~w a's value:~w~n",[Tag,V]),
	loop(Tag).

sleep() ->
	receive 
	after 3000 -> true
	end.
