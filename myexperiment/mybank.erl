-module(mybank).

-behaviour(gen_server).
-compile(export_all).
-define(SERVER,?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE,[],[]).

stop() -> gen_server:call(?MODULE,stop).

new_account(Who) -> gen_server:call(?MODULE, {new,Who}).

deposit(Who,Amount) -> gen_server:call(?MODULE, {add,Who,Amount}).

withdraw(Who,Amount) -> gen_server:call(?MODULE, {remove,Who,Amount}).


init([]) -> {ok, ets:new(?MODULE,[])}.

handle_call({new, Who},_From,Tab) ->
		Reply = case ets:lookup(Tab,Who) of
			[] -> ets:insert(Tab, {Who,0}),
				{welcome, Who};
			[_]-> {Who, you_already_are_customer}
		end,
	{reply,Reply,Tab};

handle_call({add, Who,Amount},_From, Tab) ->
		Reply = case ets:lookup(Tab,Who) of
			[] -> {Who, not_a_customer};
			[{Who,Balance}] ->
				NewBalance = Balance+ Amount,
				ets:insert(Tab,{Who,NewBalance}),
				{thanks,Who, your_balance_is, NewBalance}
			end,
	{reply,Reply,Tab};

handle_call({remove,Who,Amount},_From,Tab) ->
		Reply = case ets:lookup(Tab,Who) of
			[] -> {Who, not_a_customer};
			[{Who,Balance}] when Amount>Balance ->
					{sorry,Who,you_have_balance,Balance};
			[{Who,Balance}] ->
					NewBalance = Balance - Amount,
					ets:insert(Tab,{Who,NewBalance}),
					{thanks,Who,your_balance_is, NewBalance}
			end,
	{reply,Reply,Tab};

handle_call(stop,_From,Tab) ->
	{stop,normal,stopped,Tab}.

handle_cast(_Msg, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.
