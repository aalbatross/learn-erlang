-module(shopping).
-export([cost/1,total_cost/1,list_items/0,total/1]).

cost(oranges) -> 5;
cost(grapes) -> 10;
cost(apples) -> 50;
cost(milk) -> 15.


total_cost({items,{oranges,N1},{grapes,N2},{apples,N3},{milk,N4}}) ->
	((N1 * cost(oranges)) +(N2 * cost(grapes))+ (N3* cost(apples))+ (N4*cost(milk))).

list_items() -> [oranges,grapes,apples,milk].

total([{What,N}|T]) -> cost(What) * N + total(T);
total([]) -> 0.
