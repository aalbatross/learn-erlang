-module(fileclient).
-export([list/2,content/2]).

list(Dir,X) ->
	X ! {self(),{ls,Dir}},
	receive
		Response -> Response
	end.

content(File,X) ->
	X ! {self(),{content,File}},
	receive
		Response -> Response
	end.
