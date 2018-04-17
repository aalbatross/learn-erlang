-module(job_centre).

-compile(export_all).

-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

stop() -> gen_server:call(?MODULE,stop).

add_job(F) -> gen_server:call(?MODULE,{add_job,F}).

work_wanted() -> gen_server:call(?MODULE,{exec_next}).

job_done(JobNumber) -> gen_server:call(?MODULE,{job_done,JobNumber}).

statistics() -> gen_server:call(?MODULE, {statistics}).

init([]) -> {ok, ets:new(?MODULE,[duplicate_bag])}.

handle_call(stop,_From,Tab) ->
		{stop,normal,stopped,Tab};

handle_call({add_job,F}, _From,Tab) ->
			ets:insert(Tab,{job,F}),
			{reply,ok,Tab};

handle_call({exec_next},_From,Tab) ->
			Reply= case ets:lookup(Tab,ets:first(Tab)) of
			[] -> nothing_to_exec;
			[{job,F}] -> spawn(fun() -> F(),job_done(ets:first(Tab)),ets:delete(Tab,ets:first(Tab)) end)
			end,
			{reply,Reply,Tab};
			
handle_call({job_done,JobNumber},_From,Tab) ->
			Reply = {JobNumber,is_done},
			{reply,Reply,Tab};

handle_call({statistics},_From,Tab) ->
			{reply,unsupported,Tab}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.
			
