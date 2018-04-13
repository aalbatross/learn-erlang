-module(agentserver).
-export([init/0,loop/0,connect_cluster/1,list_nodes/0,find_head/0]).


init() -> global:register_name(node(),spawn(agentserver,loop,[])).

connect_cluster(Master) ->
	net_adm:ping(Master).

list_nodes() ->
	[node()|nodes()].

find_head() ->
	lists:nth(1,lists:sort(list_nodes())).

loop() ->
	receive 
		{From, connect, Master} ->
			From ! {self(),connect_cluster(Master),fine};
		{From, list} ->
			From ! {self(),list_nodes()};
		{From, head} ->
			From ! {self(),find_head()}
	end,
	loop(). 
		
