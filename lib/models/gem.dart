class Gem {
  String? id;
  String? name;
  String? identifier;
  String? secret;
  String? type;
  String? imageurl;
  DateTime? created_at;
  DateTime? updated_at;

  Gem(
      {this.id,
      this.name,
      this.identifier,
      this.secret,
      this.type,
      this.imageurl,
      this.created_at,
      this.updated_at});

  Gem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    identifier = json['identifier'];
    secret = json['secret'];
    type = json['type'];
    imageurl = json['imageurl'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['identifier'] = identifier;
    data['secret'] = secret;
    data['type'] = type;
    data['imageurl'] = imageurl;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}
