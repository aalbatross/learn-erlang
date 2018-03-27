-module(miscerror).
-export([myspawn/3,on_exit/2,myspawn_withtime/4,on_time_kill/2]).


on_exit(Pid,Fun) ->
	spawn(fun() -> 
			Start = now(),
			Ref = monitor(process,Pid),
			receive
				{'DOWN',Ref,process,Pid,Why} ->
					Fun(Why),
					io:format("Time run: ~w~n",[timer:now_diff(now(),Start)])

			end
	end).


on_time_kill(Pid,Time) -> 
	spawn(fun() ->
			monitor(process,Pid),
			receive
			after Time ->
				io:format("Time Expired killing ...~n"),
				exit(Pid,kill)
			end
	end).

myspawn(M,F,A) ->
	on_exit(spawn(M,F,A), fun(Why) -> io:format("~w~n",[Why]) end).


myspawn_withtime(M,F,A,Time) ->
	on_time_kill(spawn(M,F,A),Time).


