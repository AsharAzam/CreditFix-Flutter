class Station {
  int? id;
  String? name;
  String? address;
  String? ptcl;
  bool isActive = false;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  Station(
      {this.id,
      this.name,
      this.address,
      this.ptcl,
      this.isActive = false,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    ptcl = json['ptcl'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['ptcl'] = this.ptcl;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
