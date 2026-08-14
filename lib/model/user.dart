class User {
  String? name;
  String? email;
  String? id;
  List<String>? favorites;

  User({this.id, this.email, this.name, this.favorites});

  User.fromFireStore(Map<String, dynamic>? data) {
    name = data?["name"];
    id = data?["id"];
    email = data?["email"];
    favorites = List<String>.from(data?["favorites"] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "id": id,
      "email": email,
      "favorites": favorites ?? [],
    };
  }
}