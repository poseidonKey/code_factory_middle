import 'dart:convert';

import 'package:code_factory_middle/common/const/data.dart';

class DataUtils {
  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }

  static String pathToURL(String value) {
    return 'http://$ip$value';
  }

// server에서 dynamic으로 보내주기 때문에 String 타입 제거
  static List<String> listPathsToUrls(List paths) {
    return paths
        .map(
          (e) => pathToURL(e),
        )
        .toList();
  }

  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);
    return encoded;
  }
}
