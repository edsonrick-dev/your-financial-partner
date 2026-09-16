enum LearnContentType {
  article,
  video;

  String get label {
    switch (this) {
      case LearnContentType.article:
        return 'Article';
      case LearnContentType.video:
        return 'Video';
    }
  }

  String get actionLabel {
    switch (this) {
      case LearnContentType.article:
        return 'read';
      case LearnContentType.video:
        return 'watch';
    }
  }
}
