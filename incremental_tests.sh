
#!/bin/bash
echo "Preparing Code for Pull Request";



echo "Running Unit Tests (This may take a while)...";
python3 -m pytest --disable-pytest-warnings ./tfq
exit_code=$?
if [ "$exit_code" -ne "0" ]; then
  echo "Unittests failed.";
	exit 128;
fi

echo "Running Functional Tests (This may take a while)...";
python3 -m pytest --disable-pytest-warnings ./examples/examples_test.py
exit_code=$?
if [ "$exit_code" -ne "0" ]; then
	echo "Functional tests failed."
	exit 128;
fi

echo "All tests passed, you are now ready to create your Pull Request!"
exit 0;
