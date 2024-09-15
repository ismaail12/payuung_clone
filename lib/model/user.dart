import 'dart:convert';

class User {
  // Personal Data
  String? fullName;
  DateTime? birthDate;
  String? gender;
  String? email;
  String? phoneNumber;
  String? education;
  String? maritalStatus;

  // Address Data
  String? nik;
  String? addressKtp;
  String? province;

  // Company Data
  String? companyName;
  String? companyAddress;
  String? jobTitle;
  String? incomeSource;
  String? yearlyGrossIncome;
  String? bankBranch;
  String? bankAccountNumber;
  String? bankAccountHolder;

  User({
    this.fullName,
    this.birthDate,
    this.gender,
    this.email,
    this.phoneNumber,
    this.education,
    this.maritalStatus,
    this.nik,
    this.addressKtp,
    this.province,
    this.companyName,
    this.companyAddress,
    this.jobTitle,
    this.incomeSource,
    this.yearlyGrossIncome,
    this.bankBranch,
    this.bankAccountNumber,
    this.bankAccountHolder,
  });

  // fromJson method
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      education: json['education'],
      maritalStatus: json['maritalStatus'],
      nik: json['nik'],
      addressKtp: json['addressKtp'],
      province: json['province'],
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      jobTitle: json['jobTitle'],
      incomeSource: json['incomeSource'],
      yearlyGrossIncome: json['yearlyGrossIncome'],
      bankBranch: json['bankBranch'],
      bankAccountNumber: json['bankAccountNumber'],
      bankAccountHolder: json['bankAccountHolder'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'education': education,
      'maritalStatus': maritalStatus,
      'nik': nik,
      'addressKtp': addressKtp,
      'province': province,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'jobTitle': jobTitle,
      'incomeSource': incomeSource,
      'yearlyGrossIncome': yearlyGrossIncome,
      'bankBranch': bankBranch,
      'bankAccountNumber': bankAccountNumber,
      'bankAccountHolder': bankAccountHolder,
    };
  }

  // fromRawJson method
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  // toRawJson method
  String toRawJson() => json.encode(toJson());
}
