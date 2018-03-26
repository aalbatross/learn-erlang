-module(misc).
-export([my_tuple_to_list/1,my_time_fun/1,my_date_time/0]).

my_tuple_to_list(Tuple) -> [element(I,Tuple) || I <- lists:seq(1,tuple_size(Tuple))].

my_time_fun(F) -> B = now(), F(), A = now(), {timer:now_diff(A,B)}.

my_date_time() -> io:format("Date: ~w~3w~5w Time: ~w~3w~3w~n",lists:reverse(tuple_to_list(date()))++tuple_to_list(time())).
