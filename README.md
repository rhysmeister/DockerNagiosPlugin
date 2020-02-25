# DockerNagiosPlugin
A Docker container to facilitate the testing of Nagios Plugins
  * Place plugins to test in plugin/
  * Put tests in tests/. These files should have the same name as the respective plugin.
  * Tests written using the bats framework - https://github.com/sstephenson/bats
  * shellcheck is also executed against each plugin. https://github.com/koalaman/shellcheck/blob/master/README.md
  * Bind mounts are used to provide the plugins and tests to the container.
  * Add your own Nagios plugins and tests to these directories.
  * Scripts can be added to ./setup. These will be executed when the container starts.

# Build command

```
docker build . -t rhyscampbell/dockernagiosplugin:latest
```

Run tests in Docker container and output to terminal. Execute cmd in repo


```
docker run  --mount "type=bind,src=$(pwd)/plugins,dst=/opt/plugins"\
            --mount "type=bind,src=$(pwd)/tests,dst=/opt/tests"\
            --mount "type=bind,src=$(pwd)/setup,dst=/opt/setup"\
             -ti --rm rhyscampbell/dockernagiosplugin:latest
```

The output will look something like below if only dummy_plugin tests exist...

> Linux eb13d0455978 4.19.76-linuxkit #1 SMP Thu Oct 17 19:31:58 UTC 2019 x86_64 GNU/Linux
> GNU bash, version 5.0.11(1)-release (x86_64-alpine-linux-musl) Copyright (C) 2019 Free Software Foundation, Inc. License > > > GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> This is free software; you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
> Bats 1.1.0
> Running setup scripts
> =====================
> I am script 2
> I am script 1
> There are 1 plugins to test.
> Executing tests for ./dummy_plugin
> ===========================
> 1..6
> ok 1 Incorrect number of parameters
> ok 2 OK
> ok 3 WARNING
> ok 4 CRITICAL
> ok 5 UNKNOWN
> ok 6 INVALID
> ===========================
> Executing shellcheck for ./dummy_plugin
>
> In ./dummy_plugin line 9:
>   echo "$MSG";
>         ^--^ SC2250: Prefer putting braces around variable references even when not strictly required.
>
> Did you mean:
>   echo "${MSG}";
>
>
> In ./dummy_plugin line 10:
>   exit "$STATUS";
>         ^-----^ SC2250: Prefer putting braces around variable references even when not strictly required.
>
> Did you mean:
>   exit "${STATUS}";
>
> For more information:
>   https://www.shellcheck.net/wiki/SC2250 -- Prefer putting braces around vari...
