class Resource {

  String? title;
  String? file;
  String? mimeType;

  Resource({
    this.title,
    this.file,
    this.mimeType
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      title: json['title'],
      file: json['file'],
      mimeType: json['mime_type'],
    );
  }
}