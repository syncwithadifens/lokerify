class JobModel {
  String? id;
  String? name;
  String? category;
  String? companyName;
  String? companyLogo;
  String? location;
  List<String>? about;
  List<String>? qualifications;
  List<String>? responsibilities;
  int? createdAt;
  int? updatedAt;

  JobModel({
    this.id,
    this.name,
    this.category,
    this.companyName,
    this.companyLogo,
    this.location,
    this.about,
    this.qualifications,
    this.responsibilities,
    this.createdAt,
    this.updatedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        category: json['category'] as String?,
        companyName: json['companyName'] as String?,
        companyLogo: json['companyLogo'] as String?,
        location: json['location'] as String?,
        about: json['about'] as List<String>?,
        qualifications: json['qualifications'] as List<String>?,
        responsibilities: json['responsibilities'] as List<String>?,
        createdAt: json['createdAt'] as int?,
        updatedAt: json['updatedAt'] as int?,
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
