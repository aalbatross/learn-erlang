-module(nameserver).
-export([init/0,add/2,find/1,handle/2]).
-import(genserver2,[rpc/2]).

add(Name,Place) -> rpc(nameserver, {add,Name,Place}).
find(Name) -> rpc(nameserver, {find,Name}).

init() -> dict:new().

handle({add,Name,Place},Dict) -> {ok,dict:store(Name,Place,Dict)};
handle({find,Name},Dict) -> {dict:find(Name,Dict),Dict}.


