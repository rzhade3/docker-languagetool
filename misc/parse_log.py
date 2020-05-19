import os
import sys
import json

warning_message = u'::warning file={},line={},col={}::{}'
suggestion_message = u'{} Suggestions: `{}`'

def get_line_and_column(filename, offset):
	github_workspace = os.environ['GITHUB_WORKSPACE']
	filepath = os.path.join(github_workspace, filename)
	with open(filepath, 'r', encoding='UTF-8') as f:
		column = 1
		line = 1
		for i in range(offset):
			if f.read(1) == '\n':
				line += 1
				column = 1
			else:
				column += 1
		return line, column


parsed_filename = sys.argv[1]
logfile = sys.argv[2]
with open(logfile, 'r', encoding='UTF-8') as f:
	lines = f.readlines()
	# The front matter might contain error messages, etc. Printing out
	# so you can debug in the actions log
	front_matter = ''.join(lines[0:-2])
	print(front_matter)

	# The JSON outputted will be the last line
	print("Here's the JSON")
	a = json.loads(lines[-1])
	for match in a["matches"]:
		replacement_suggestions = list(map(lambda replacement: replacement["value"], match["replacements"]))
		replacement_string = "; ".join(replacement_suggestions)
		msg = suggestion_message.format(match["message"], replacement_string)
		line, column = get_line_and_column(parsed_filename, match["offset"])
		warning = warning_message.format(parsed_filename, line, column, msg)
		print(warning)
