-module(rebar3_dirs_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, dirs).
-define(DEPS, [app_discovery]).


%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider = providers:create([
        {name, ?PROVIDER},            % The 'user friendly' name of the task
        {module, ?MODULE},            % The module implementation of the task
        {bare, true},                 % The task can be run by the user, always true
        {deps, ?DEPS},                % The list of dependencies
        {example, "rebar3 " ++ atom_to_list(?PROVIDER)}, % How to use the plugin
        {opts, []},                   % list of options understood by the plugin
        {short_desc, "A rebar plugin to list rebar3 directories"},
        {desc, "A rebar plugin to list important directories for rebar3"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.


-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    case rebar_state:command_args(State) of
        [] ->
            do_all(State);
        Args ->
            do_args(State, Args)
    end.

do_all(State) ->
    [io:format("~p: ~ts~n", [P, rebar_dir:P(State)]) || P <- state_paths()],
    {ok, State}.

do_args(State, Args) ->
    try
        [io:format("~ts~n", [path(A, State)]) || A <- Args],
        {ok, State}
    catch
        throw:Reason ->
            {error, {?MODULE, Reason}}
    end.

-spec format_error(any()) ->  iolist().
format_error({invalid_arg, Arg}) ->
    io_lib:format("Invalid Path for dirs command: ~p", [Arg]).

path(P, State) when is_atom(P) ->
    rebar_dir:P(State);
path(P, State) when is_list(P) ->
    P2 = fix_path(P),
    path(P2, State).

fix_path(P) when is_list(P) ->
    P2 = list_to_atom(P),
    case lists:member(P2, state_paths()) of
        true ->
            P2;
        false ->
            throw({invalid_arg, P})
    end.


state_paths() ->
    [
        base_dir,
        deps_dir,
        root_dir,
        checkouts_dir,
        checkouts_out_dir,
        plugins_dir,
        lib_dirs,
        project_plugin_dirs,
        global_config_dir,
        global_config,
        template_dir
    ].
