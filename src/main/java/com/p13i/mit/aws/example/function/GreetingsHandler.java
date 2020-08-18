package com.p13i.mit.aws.example.function;

import com.amazonaws.services.lambda.runtime.Context;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.Map;

import static com.p13i.mit.aws.example.utils.FunctionResourceBundle.*;

public class GreetingsHandler {
    static final Logger log = LogManager.getLogger(GreetingsHandler.class);

    public String handleRequest(final Map<String, Object> input, final Context context) {

        try {
            log.info("Starting to handle request with ID {}", context.getAwsRequestId());

            log.info("Input is {}", input); //passed in parameter values

            String greeting = getString("greeting.hello", input.get("name"));

            log.info("Constructed greeting is: {}", greeting);

            log.info("Completed handling request with ID {}", context.getAwsRequestId());
            return greeting;
        } catch (Exception e) {
            log.fatal("Error while handling request with ID {}", context.getAwsRequestId(), e);
            return getString("greeting.error", e.getMessage());
        }
    }
}
