class YouTubeUrlValidator {
  const YouTubeUrlValidator._();

  static final RegExp _videoIdPattern = RegExp(r'^[a-zA-Z0-9_-]{11}$');

  static String? videoIdFromUrl(final String value) {
    final Uri? uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasAuthority || uri.scheme != 'https') {
      return null;
    }

    final String host = uri.host.toLowerCase();
    String? videoId;

    if (host == 'youtu.be' || host == 'www.youtu.be') {
      if (uri.pathSegments.length == 1) {
        videoId = uri.pathSegments.first;
      }
    } else if (<String>[
      'youtube.com',
      'www.youtube.com',
      'm.youtube.com',
    ].contains(host)) {
      if (uri.path == '/watch') {
        videoId = uri.queryParameters['v'];
      } else if (uri.pathSegments.length == 2 &&
          <String>[
            'shorts',
            'embed',
            'live',
          ].contains(uri.pathSegments.first)) {
        videoId = uri.pathSegments[1];
      }
    }

    return videoId != null && _videoIdPattern.hasMatch(videoId)
        ? videoId
        : null;
  }

  static bool isValidOrEmpty(final String value) =>
      value.trim().isEmpty || videoIdFromUrl(value) != null;
}
