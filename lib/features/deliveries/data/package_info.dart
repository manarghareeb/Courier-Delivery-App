class PackageInfo {
  final String weight;
  final String size;
  final String contents;

  PackageInfo({
    required this.weight,
    required this.size,
    required this.contents,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    return PackageInfo(
      weight: json['weight'],
      size: json['size'],
      contents: json['contents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'size': size,
      'contents': contents,
    };
  }

}