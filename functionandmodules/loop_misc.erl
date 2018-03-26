-module(loop_misc).
-export([while/2,for/3]).


while(L,F) -> while(L,F,0).
while([],F,Acc) -> loop_completed;

while([H|T],F,Acc) -> 
	F(H,Acc),
	while(T,F,Acc+1).

for(Max,Max,F) -> loop_completed;
for(I,Max,F) -> 
	F(I),
	for(I+1,Max,F).
