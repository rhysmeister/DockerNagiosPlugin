#/bin/bash
#set -x;
set -u;
set -e;

echo "$(uname -a)";
echo $(bash --version);
echo $(bats --version);

chmod 0755 /opt/plugins/*;
chmod 0755 /opt/tests/*;
chmod 0755 /opt/setup/*;

cd /opt/setup;
SETUP_COUNT=$(find . -type f | wc -l);

if (( SETUP_COUNT > 0 )); then
  echo "Running setup scripts";
  echo "=====================";
  for setup_script in $(find . -type f); do
    "$setup_script";
  done;
fi;

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
    echo "Executing shellcheck for $plugin"
    shellcheck -o all "$plugin";
  done
  exit 0;
else
  echo "No plugins found in $(pwd)";
  exit 1;
fi;
