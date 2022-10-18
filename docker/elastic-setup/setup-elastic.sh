#!/bin/bash

curl --user elastic:pass123 "http://elasticsearch:9200/_cluster/health?wait_for_status=green"
curl --user elastic:pass123 -XPUT "http://elasticsearch:9200/_cluster/settings" -H 'Content-Type: application/json' -d'{  "persistent" : {    "xpack.ml.max_open_jobs" : "512"  }}'

mappings=$(ls -A /tmp/mappings | grep -e "_mapping.json")
for mapping in $mappings
do
  filename=$(basename "$mapping")
  index=${filename%%_mapping.json}
  printf "\nCreating index for: %s\n" "$index"
  curl --user elastic:pass123 -XPUT "http://elasticsearch:9200/$index" -H "Content-Type: application/json" -d "@/tmp/mappings/$mapping"
  curl --user elastic:pass123 -XPOST "http://elasticsearch:9200/$index/_bulk" -H "Content-Type: application/x-ndjson" --data-binary "@/tmp/mappings/docs/$index.json"
  printf "\nFinished creating index for: %s\n" "$index"
done
printf "\nFinished creating all mappings\n"
