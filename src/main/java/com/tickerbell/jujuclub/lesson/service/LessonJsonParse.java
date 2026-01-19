package com.tickerbell.jujuclub.lesson.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LessonJsonParse {

  private static final ObjectMapper objectMapper = new ObjectMapper();

  public static List<String> parseChoices(String optionsJson) throws IOException {
    JsonNode optionsNode = objectMapper.readTree(optionsJson).get("choices");
    return objectMapper.readValue(optionsNode.traverse(), new TypeReference<List<String>>() {});
  }

  public static List<Integer> parseDragAnswer(String answerJson) throws IOException {
    JsonNode correctNode = objectMapper.readTree(answerJson).get("correct");
    return objectMapper.readValue(correctNode.traverse(), new TypeReference<List<Integer>>() {});
  }

  public static String parseSingleAnswer(String answerJson) throws IOException {
    JsonNode correctNode = objectMapper.readTree(answerJson).get("correct");
    return correctNode.get(0).asText();
  }

  public static String parseExplanation(String answerJson) throws IOException {
    return objectMapper.readTree(answerJson).get("explanation").asText();
  }

  public static Map<String, String> parseMatchAnswer(String answerJson) throws IOException {
    JsonNode correctNode = objectMapper.readTree(answerJson).get("correct");
    return objectMapper.readValue(correctNode.traverse(), new TypeReference<Map<String, String>>() {});
  }

  public static Map<String, List<Map<String, String>>> parseMatchOptions(String optionsJson) throws IOException {
    JsonNode node = objectMapper.readTree(optionsJson);
    Map<String, List<Map<String, String>>> map = new HashMap<>();
    map.put("left", objectMapper.readValue(node.get("left").traverse(), new TypeReference<List<Map<String, String>>>() {}));
    map.put("right", objectMapper.readValue(node.get("right").traverse(), new TypeReference<List<Map<String, String>>>() {}));
    return map;
  }
}
