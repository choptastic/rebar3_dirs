-module(rebar3_dirs).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, State1} = rebar3_dirs_prv:init(State),
    {ok, State1}.
