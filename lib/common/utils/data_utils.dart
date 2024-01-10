import 'package:code_factory_middle/common/const/data.dart';

class DataUtils {
  static String pathToURL(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsToUrls(List<String> paths) {
    return paths
        .map(
          (e) => pathToURL(e),
        )
        .toList();
  }
}
