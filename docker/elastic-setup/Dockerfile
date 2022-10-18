FROM debian:stretch-slim

RUN set -x \
	&& apt update \
	&& apt install -y wait-for-it curl \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./elastic-setup/setup-elastic.sh /tmp/setup-elastic.sh

# Copy the mappings files EXACTLY with the format "[indexName]_mapping.json"
COPY ./elastic-setup/test/test_mapping.json /tmp/mappings/test_mapping.json
COPY ./elastic-setup/test/docs/docs.json /tmp/mappings/docs/test.json

CMD ["wait-for-it", "elasticsearch:9200", "-t", "0", "--", "/tmp/setup-elastic.sh"]
