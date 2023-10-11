enum UserType { User, organizer, restoOwner }

Map<String, UserType> userTypeMap = {
  'User': UserType.User,
  'organizer': UserType.organizer,
  'restoOwner': UserType.restoOwner,
};

class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  UserType userType;
  UserModel(
      {required this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.userType = UserType.User,
      this.photoUrl});
}
