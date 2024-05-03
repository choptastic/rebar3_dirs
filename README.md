# rebar3_dirs

A rebar plugin to print important directories. This is particularly useful if
you are in an environment where the `REBAR_CACHE_DIR` environment variable is
being set, as that can cause some
[confusion](https://github.com/erlang/rebar3/issues/2762)

## Add to `rebar.config`

Add the plugin to your rebar config:

    {plugins, [
        [rebar3_dirs]
    ]}.

## Usage

### Printing all directories

Then just call your plugin from the shell

```bash
$ rebar3 dirs
base_dir: /home/user/code/myapp/_build/default
deps_dir: /home/user/code/myapp/_build/default/lib
root_dir: /home/user/code/myapp/.
checkouts_dir: /home/user/code/myapp/_checkouts
checkouts_out_dir: /home/user/code/myapp/_build/default/checkouts
plugins_dir: /home/user/code/myapp/_build/default/plugins
lib_dirs: apps/*lib/*.
project_plugin_dirs: plugins/*
global_config_dir: /home/user/kerl/26.2.4/.cache/rebar3/.config/rebar3
global_config: /home/user/kerl/26.2.4/.cache/rebar3/.config/rebar3/rebar.config
template_dir: /home/user/kerl/26.2.4/.cache/rebar3/.config/rebar3/templates
```

### Printing a single directory

If you want just a single value (like `template_dir`) or multiple specific
values, add the desired value keys to the end of the `rebar3` call

```bash
$ rebar3 dirs template_dir
/home/user/kerl/26.2.4/.cache/rebar3/.config/rebar3/templates

$ rebar3 dirs template_dir checkouts_dir
/home/user/kerl/26.2.4/.cache/rebar3/.config/rebar3/templates
/home/user/code/myapp/_checkouts/
```

## About

Copyright 2024 [Jesse Gumm](http://jessegumm.com)

Licensed under Apache 2.0
