{
	count = 0
	prev = $0
	prevfile = $2

	for (;;) {
		if ((getline line) <= 0)
			unexpected_eof()

		split(line, fields, /	/)

		if (prevfile == fields[2])
		{
			count++
			print prev
		}
		else
		{
			if (count > 0)
			{
				print prev
			}
			count = 0
		}
		prevfile = fields[2]
		prev = line
	}
}

function unexpected_eof() {
	exit 1
}
