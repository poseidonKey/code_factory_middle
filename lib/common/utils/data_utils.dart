import 'package:code_factory_middle/common/const/data.dart';

class DataUtils {
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
}
