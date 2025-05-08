import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/global/function/formatter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  DateTime? dateTime;
  bool? selectedAddress;
  String? user_id;
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
    this.user_id
  });

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber!);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');
  Map<String, dynamic> toJsonSupabase() {
      final userId = user_id ?? Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) {
    throw "User ID is required.";
  }
    return {
      
      'Name': name,
       'user_id':  user_id ??      Supabase.instance.client.auth.currentUser!.id,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
     'DateTime':  DateTime.now().toIso8601String() ,
      'SelectedAddress': selectedAddress
     
    };
  }

  AddressModel.fromJsonSupabase(Map<String, dynamic> json) {
    id = json['AddresId'];
    name = json['Name'];
      dateTime = DateTime.parse(json['DateTime'] );
    phoneNumber = json['PhoneNumber'] ?? '';
    street = json['Street'] ?? '';
    city = json['City'] ?? '';
    state = json['State'] ?? '';
    postalCode = json['PostalCode'] ?? '';
    country = json['Country'] ?? '';
  
    selectedAddress = json['SelectedAddress'] as bool;
  }

  Map<String, dynamic> toJson() {
    return {
      'AddresId': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['AddresId'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      postalCode: data['PostalCode'] as String,
      country: data['Country'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

// Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}
