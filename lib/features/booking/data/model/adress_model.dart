class AddressModel {
  final String houseNumber;
  final String streetNumber;
  final String completeAddress;

  AddressModel({
    required this.houseNumber,
    required this.streetNumber,
    required this.completeAddress,
  });

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      houseNumber: data['houseNumber'] as String,
      streetNumber: data['streetNumber'] as String,
      completeAddress: data['completeAddress'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'houseNumber': houseNumber,
      'streetNumber': streetNumber,
      'completeAddress': completeAddress,
    };
  }
}
