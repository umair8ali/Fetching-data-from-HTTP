class Repo {
  final String title;
  final String owner;
  final String url;
  final String? description;

  Repo({
    required this.title,
    required this.owner,
    required this.url,
    required this.description,
  });

  // Factory constructor to parse JSON
  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      title: json['name'],
      owner: json['owner']['login'],
      url: json['url'],
      description: json['description'],
    );
  }
}
