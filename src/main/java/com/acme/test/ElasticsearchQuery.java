package com.acme.test;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.model.dataformat.JsonLibrary;

public class ElasticsearchQuery extends RouteBuilder {
    @Override
    public void configure() throws Exception {

        from("timer:java_dsl?period=60000")
            .setHeader("Content-Type", simple("application/json"))
            .setBody(simple("{{myQuery}}"))
            .to("elasticsearch-rest://elasticsearch?enableSSL=false&operation=SEARCH&indexName=test&hostAddresses=localhost%3A9200")
            .marshal().json(JsonLibrary.Jackson)
            .log("From Java DSL ${body}")
            .end();
    }
}
