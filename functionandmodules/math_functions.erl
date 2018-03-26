-module(math_functions).
-export([even/1,odd/1,filter_new/2,filter_lc/2,even_and_odd/1]).

even(X) -> X rem 2 ==0.

odd(X) -> X rem 2 ==1.

filter_lc(L,F) -> [X || X<-L,F(X)].

filter_new(L,F) -> filter_new(L,F,[]). 
filter_new([],F,Acc) -> Acc;
filter_new([H|T],F,Acc) ->
	case true == F(H) of
		true ->
		    	filter_new(T,F,[H|Acc]);
		false ->
		       	filter_new(T,F,Acc)
	end.

even_and_odd(L) ->
	even_and_odd(L,[],[]).

even_and_odd([],Even,Odd)->{Even,Odd};
even_and_odd([H|T],Even,Odd) ->
	case H rem 2  of
		1 -> even_and_odd(T,Even,[H|Odd]);
		0 -> even_and_odd(T,[H|Even],Odd)
	end.
	
