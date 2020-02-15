# DockerNagiosPlugin
A Docker container to facilitate the testing of Nagios Plugins
  * Place plugins to test in plugin/
  * Put tests in tests/. These files should have the same name as the respective plugin.
  * Tests written using the bats framework - https://github.com/sstephenson/bats
  * shellcheck is also executed against each plugin. https://github.com/koalaman/shellcheck/blob/master/README.md

# Build command

```
docker build . -t rhyscampbell/dockernagiosplugin:latest
```

Run tests in Docker container and output to terminal

```
docker run -ti --rm rhyscampbell/dockernagiosplugin:latest
```

The output will look something like below if only dummy_plugin tests exist...

> Linux 2b10802e864a 4.19.76-linuxkit #1 SMP Thu Oct 17 19:31:58 UTC 2019 x86_64 GNU/Linux
> GNU bash, version 5.0.11(1)-release (x86_64-alpine-linux-musl) Copyright (C) 2019 Free Software Foundation, Inc. License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> This is free software; you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
> Bats 1.1.0
> There are 1 plugins.
> Executing tests for ./dummy_plugin
> ===========================
> 1..6
> ok 1 Incorrect number of parameters
> ok 2 OK
> ok 3 WARNING
> ok 4 CRITICAL
> ok 5 UNKNOWN
> ok 6 INVALID

# TODO

* how to copy plugins & tests at runtime? Volumes?
