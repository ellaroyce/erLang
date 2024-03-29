-module(atm_sup).
-behaviour(supervisor).
-export([start_link/0,
             init/1]).

% идеи взяты из http://levgem.livejournal.com/404182.html

-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, { {one_for_one, 5, 5},
        [
            ?CHILD(atm_server, worker),
            ?CHILD(transactions_server, worker)
        ]
    } }.
