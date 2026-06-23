import 'package:http_parser/http_parser.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty || this == 'null';
  }

  bool get isPdf {
    return this?.toLowerCase().contains('pdf') ?? this?.contains('.pdf') ?? false;
  }
}

/// isNullOrEmpty Extensions for List
extension ListExtension on List<dynamic>? {
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }
}

/// An extension that let us easily control over the DateTime.now();
extension MutableDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}

extension GetMediaTypeFromFileExtension on String {
  MediaType getMediaType() {
    String mediaType = '';
    String attachType = split('.').last.toLowerCase();
    if (['png', 'jpg', 'jpeg'].contains(attachType)) {
      mediaType = 'image';
    }
    if (['pdf', 'doc', 'docx', 'msg'].contains(attachType)) {
      mediaType = 'application';
    }
    return MediaType(mediaType, attachType);
  }
}

extension DateTimeExtensions on DateTime {
  // Get the first day of the month
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  // Get the last day of the month
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }
}
