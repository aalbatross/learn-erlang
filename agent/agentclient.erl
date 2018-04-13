-module(agentclient).
-export([connect_cluster/2,list_nodes/1,find_head/1]).

connect_cluster(Master,X) ->
	X ! {self(),connect, Master},
	receive
		Response -> Response
        end.

list_nodes(X) ->
        X ! {self(),list},
	receive
		Response -> Response
	end.

find_head(X) ->
        X ! {self(),head},
	receive
		Response -> Response
	end.
