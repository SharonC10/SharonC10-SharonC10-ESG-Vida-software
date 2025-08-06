import 'package:path/path.dart' as path;

class FileUtils {
  static String basename(String filepath) {
    return path.basename(filepath);
  }

  /// [exts] is lower case, url也行
  static bool isSupport(List<String> exts, String filepath) {
    return exts.contains(filext(filepath).toLowerCase());
  }

  static String filext(String filepath) {
    return path.extension(filepath);
  }

  /// contain .
  static String join(List<String> partPathList) {
    return path.joinAll(partPathList);
  }

  static String basenameWithoutExt(String filepath) {
    return path.basenameWithoutExtension(filepath);
  }
}
