
echo "Ensuring proper linting/formatting...";
linting_outputs=$(python3 -m pylint ./tfq ./examples);
exit_code=$?
if [ "$exit_code" == "0" ]; then
	echo "Linting Complete!";
else
	echo "Linting failed, please correct errors before proceeding."
	echo "{$linting_outputs}"
	exit 64;
fi
