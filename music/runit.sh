find -name *.ogg -printf '%p	%f	%s\n' | sort > list.txt
sed -i 's/ ([0-9]).ogg	\([0-9]*\)$/.ogg	\1/' list.txt
awk -f dupes.awk -F '	' list.txt > dupelist.txt
echo "asd	asd	0" >> dupelist.txt
awk -f dedupe.awk -F '	' dupelist.txt | sed '/mv/ s/ ([0-9]).ogg/.ogg/2' > dedupe.sh
sed -i "s/\([a-zA-Z]\)'\([a-zA-Z]\)/\1''\2/g" dedupe.sh
/bin/sh dedupe.sh
