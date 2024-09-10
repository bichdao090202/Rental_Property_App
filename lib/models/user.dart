class User {
  int id;
  String name;
  String? email;
  String? phoneNumber;
  String? profileImage;

  User({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    this.profileImage,
  });

  void updateProfile({
    String? newName,
    String? newEmail,
    String? newPhoneNumber,
    String? newProfileImage,
  }) {
    if (newName != null) {
      this.name = newName;
    }
    if (newEmail != null) {
      this.email = newEmail;
    }
    if (newPhoneNumber != null) {
      this.phoneNumber = newPhoneNumber;
    }
    if (newProfileImage != null) {
      this.profileImage = newProfileImage;
    }
  }

  String displayUserInfo() {
    return ('User ID: $id Name: $name');
  }
}