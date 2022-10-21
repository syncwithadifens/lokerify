class JobModel {
  String id;
  String name;
  String category;
  String companyName;
  String companyLogo;
  String location;
  List about;
  List qualifications;
  List responsibilities;
  int createdAt;
  int updatedAt;

  JobModel({
    required this.id,
    required this.name,
    required this.category,
    required this.companyName,
    required this.companyLogo,
    required this.location,
    required this.about,
    required this.qualifications,
    required this.responsibilities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        companyName: json['companyName'],
        companyLogo: json['companyLogo'],
        location: json['location'],
        about: json['about'],
        qualifications: json['qualifications'],
        responsibilities: json['responsibilities'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'companyName': companyName,
        'companyLogo': companyLogo,
        'location': location,
        'about': about,
        'qualifications': qualifications,
        'responsibilities': responsibilities,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
