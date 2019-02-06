class VeterinarianListModel {
  final String state;
  final String city;
  final String practiceName;
  final String veterinarian;
  final String phoneNumber;
  final String email;
  final String imageUrl;
  final String isHeader;

  VeterinarianListModel({this.state,
      this.city,
      this.practiceName,
      this.veterinarian,
      this.phoneNumber,
      this.email,
      this.imageUrl,
      this.isHeader = null});
}