create table T (c1 text) strict;
.import 03_data.txt T
-- load linux-amd64 regex engine for sqlite. you can find other dlls
-- here: https://github.com/asg017/sqlite-regex
.load ./regex0.so

select
	sum(regex_capture(captures, 1)*regex_capture(captures, 2))
from
  regex_captures(
	'mul\(([0-9]{1,3}),([0-9]{1,3})\)',
	regex_replace_all("don't\(\)(.*?)(do\(\)|$)", prog, "")
  )
-- concatenate the file into a single line
join (select group_concat(T.c1, '') as prog from T);