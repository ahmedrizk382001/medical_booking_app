import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name, email, phone, image, uid;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    this.phone = '',
    this.image =
        "https://firebasestorage.googleapis.com/v0/b/clinic-booking-app-627f3.appspot.com/o/UserBlankImage%2Fblank-image.png?alt=media&token=520259af-1545-46d9-a7e5-7cd55231d98a",
  });

  UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> userModel) {
    name = userModel['name'];
    email = userModel['email'];
    uid = userModel['uid'];
    phone = userModel['phone'];
    image = userModel['image'];
  }

  Map<String, dynamic> userModelToJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'uid': uid,
    };
  }
}
