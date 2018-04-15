-module(fileserver).
-export([start/0,loop/0]).

start() -> spawn(fun() -> loop() end).

loop() ->
	receive
		{From,{ls,Dir}} ->
			From ! {self(),file:list_dir(Dir)};
		{From,{content,File}} ->
			From ! {self(),file:read_file(File)};
		{From,Request} ->
			From ! {self(),{error,Request}}

		
	end,
	loop().


