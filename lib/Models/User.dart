
var a = {
  "id": 7,
  "name": "sam sam",
  "slug": "sam",
  "email": "sam@yopmail.com",
  "user_group_id": 2,
  "mobile_no": "+1-11122223491",
  "image_url":
      "https://pain2purpose.dev.retrocubedev.com/storage/users/Rq5HcQsbPEFnIuoTIPU4qCqSyXpzel5d8u8RDr4V.jpg",
  "blur_image": "LIFQy+t700bZIna{t7j[00WU~XoM",
  "status": "1",
  "gender": "He",
  "date_of_birth": "1996-06-12",
  "is_email_verify": "1",
  "is_mobile_verify": "0",
  "country": null,
  "state": null,
  "city": null,
  "zipcode": null,
  "address": null,
  "latitude": null,
  "longitude": null,
  "api_token":
      "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SnBZWFFpT2pFMk5qQTFORFk1TkRZc0ltbHpjeUk2SWxjdlJ5UjNmWE50TEVjbFN5RnJRRk1rZW1WcmEyMWtkbWhyYlR0RGFVMVJhaXBoVjNjamRqVWlMQ0p1WW1ZaU9qRTJOakExTkRZNU5EWXNJbVY0Y0NJNk1UWTJNVFF4TURrME5pd2lkWE5sY2lJNmV5SjFjMlZ5WDJsa0lqbzNMQ0pwY0Y5aFpHUnlaWE56SWpvaU1URXdMamt6TGpJMU1DNHhPVFFpTENKMVpHbGtJam9pTlZGMVFWY3lMMXB6Y0hGdWJUUkhOSGxHWVVGT05qQkZXbFV2VldSUU5UTXhXRmR3Y20weldrMTZlR1JWUVdFM2NrcG5OREY1ZURaRGJTczBMelJCU0NJc0ltUmhkR1YwYVcxbElqb2lNakF5TWkwd055MHlOMVF3TnpveU5qb3lNeTR3TURBd01EQmFJbjE5LnREUlVIczktTXFtSkttU1Z3TEwzck11aWNBM083Wkw1amh5REJTR0ttbGM=",
  "device_type": "android",
  "device_token": "1234567890",
  "platform_type": "custom",
  "platform_id": null,
  "created_at": "2022-07-27T07:26:23.000000Z"
};

class User {
  int? id;
  String? name,
      slug,
      email,
      password,
      mobile_no,
      device_token,
      api_token,
      image_url,
      date_of_birth,
      gender,
      platform_id,
      device_type;
  bool is_active = true;

  User(
      {this.id,
      this.name,
      this.slug,
      this.email,
      this.password,
      this.mobile_no,
      this.device_token,
      this.api_token,
      this.image_url,
      this.date_of_birth,
      this.gender,
      this.platform_id,
      this.device_type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] != null ? json['id'] : null,
      name: json['name'],
      slug: json['slug'],
      email: json['email'],
      password: json['password'],
      mobile_no: json['mobile_no'],
      image_url: json['image_url'],
      device_token: json['device_token'],
      date_of_birth: json['date_of_birth'],
      gender: json['gender'],
      platform_id: json['platform_id'],
      device_type: json['device_type'] != null ? json['platform_id'] : null,
      api_token: json['api_token'] != null ? json['api_token'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "slug": this.slug,
      "email": this.email,
      "password": this.password,
      "mobile_no": this.mobile_no,
      "image_url": this.image_url,
      "date_of_birth": this.date_of_birth,
      "gender": this.gender,
      "platform_id": this.platform_id,
      "device_type": this.device_type,
      "device_token": this.device_token,
      "api_token": this.api_token,
    };
  }

/*String getCreatedAt() {
    return formatDate(
        dateString: DateTime.fromMillisecondsSinceEpoch(created_at).toString());
  }*/
}
