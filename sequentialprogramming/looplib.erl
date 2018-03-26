-module(looplib).
-export([for/3,sum/1,qsort/1,pyth_triplet/1,max/2]).

for(Max,Max,F) -> [F(Max)];
for(I,Max,F) -> [F(I)|for(I+1,Max,F)].

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

qsort([]) -> [];
qsort([Pivot|T]) -> qsort([X || X <- T, X<Pivot]) ++ [Pivot] ++ qsort([X || X <- T, X>= Pivot]).

pyth_triplet(N) -> [{A,B,C} || A <- lists:seq(1,N),B <- lists:seq(1,N), C <- lists:seq(1,N), A+B+C =< N, A*A + B*B =:= C*C].

max(X,Y) when X > Y -> X;
max(X,Y) -> Y.
