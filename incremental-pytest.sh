#!/bin/bash
if [ $(git cat-file -t master) == "commit" ]
then
  rev=master
else
  echo "Cannot find master branch to compare to" >&2
  exit 1
fi


echo "Comparing against revision '${rev}'." >&2

echo {$rev}
exit
echo "Running Unit Tests (This may take a while)...";
python3 -m pytest --disable-pytest-warnings ./tfq
exit_code=$?
if [ "$exit_code" -ne "0" ]; then
  echo "Unittests failed.";
	exit 128;
fi
# Get the _test version of changed python files.
changed=$(git diff --name-only ${rev} -- \
    | grep "\.py$" \
    | sed -e "s/\.py$/_test.py/" \
    | sed -e "s/_test_test\.py$/_test.py/" \
    | perl -ne 'chomp(); if (-e $_) {print "$_\n"}' \
    | uniq \
)
num_changed=$(echo -e "${changed}" | wc -w)

# Run it.
echo "Found ${num_changed} differing files with associated tests." >&2
if [ -z "${changed}" ]; then
    exit 0
fi
pytest ${rest} ${changed}
