-module(nameclient).
-export([lookup/2,store/3]).

lookup(Key,Server) ->
	Server ! {self(),lookup,Key},
	receive
		Response ->
			Response
	end.

store(Key,Value,Server) ->
        Server ! {self(),{store,Key,Value}},
        receive 
               Response ->
                        Response
        end.

