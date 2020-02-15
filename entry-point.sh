#/bin/bash
#set -x;
set -u;
set -e;

echo "$(uname -a)";
echo $(bash --version);
echo $(bats --version);

cd /opt/plugins;
PLUGIN_COUNT=$(find . -type f | wc -l);

if (( PLUGIN_COUNT > 0 )); then
  echo "There are $PLUGIN_COUNT plugins to test.";
  for plugin in $(find . -type f); do
    echo "Executing tests for $plugin";
    echo "===========================";
    plugin_basename=$(basename "$plugin");
    "/opt/tests/$plugin_basename"
    echo "===========================";
    echo "Executing shellcheck for $plugin":
    shellcheck "$plugin";
  done
  exit 0;
else
  echo "No plugins found in $(pwd)";
  exit 1;
fi;
