#!/bin/bash
#
# Run unit tests to verify data in SQLite matches output of Cron-O-Meter.
# These output files are for 10000g of a single nutrient.
# See Testing.md in this repository for additional information.
#
declare -A testFood
# This associative array is of the form [nutr_def.nutr_no]="test file name"
testFood[12152]=pistacio.txt
testFood[11098]=sprouts.txt
testFood[14355]=tea.txt
testFood[01123]=egg.txt
testFood[01001]=saltbutter.txt
testFood[11529]=tomato.txt
testFood[14096]=wine.txt
testFood[17343]=grounddeer.txt
#testFood[]=.txt
#testFood[]=.txt
#testFood[]=.txt
for nutr in "${!testFood[@]}"; do
	echo "Testing nutr_no = $nutr in ${testFood[$nutr]} file";
	diff --suppress-common-lines -b -y <(tail -n +8 -n +8 tests/${testFood[$nutr]} | grep '\S' | grep -v '==' | grep -v '%)' | grep -v 'Biotin' | grep -v 'Chromium' | cut -c 1-36 | grep '\S' | grep -v '==' | grep -v '%)' | cut -c 1-36) <(sqlite3 -batch sr24/sr24.db "select report_line from cron_o_meter_report_data_for_QA where ndb_no = '${nutr}' ORDER BY sr_order_cron_o_meter;")
done

