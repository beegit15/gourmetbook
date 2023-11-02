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
  List<String> wishList;
  UserType userType;
  UserModel(
      {required this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.userType = UserType.User,
      this.wishList = const [],
      this.photoUrl});

  void addToWishList(String item) {
    if (wishList.isNotEmpty) {
      // Create a new list with the added item
      List<String> newWishList = List.from(wishList)..add(item);

      // Update the unmodifiable list with the new list
      wishList = newWishList;
    } else {
      // If the list is empty, just add the item
      wishList.add(item);
    }
  }

  void removeFromWishList(String item) {
    if (wishList.isNotEmpty) {
      // Create a new list without the removed item
      List<String> newWishList = List.from(wishList)..remove(item);

      // Update the unmodifiable list with the new list
      wishList = newWishList;
    }
  }
}
