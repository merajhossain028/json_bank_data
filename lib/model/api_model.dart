// To parse this JSON data, do
//
//     final interestData = interestDataFromJson(jsonString);

import 'dart:convert';

List<InterestDataModel> interestDataFromJson(String str) => List<InterestDataModel>.from(json.decode(str).map((x) => InterestDataModel.fromJson(x)));

String interestDataToJson(List<InterestDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterestDataModel {
    InterestDataModel({
        this.firstName,
        this.lastName,
        this.annualInterestRate,
        this.principalAmount,
        this.tenuresInMonth,
    });

    final String? firstName;
    final String? lastName;
    final String? annualInterestRate;
    final String? principalAmount;
    final String? tenuresInMonth;

    InterestDataModel copyWith({
        String? firstName,
        String? lastName,
        String? annualInterestRate,
        String? principalAmount,
        String? tenuresInMonth,
    }) => 
        InterestDataModel(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            annualInterestRate: annualInterestRate ?? this.annualInterestRate,
            principalAmount: principalAmount ?? this.principalAmount,
            tenuresInMonth: tenuresInMonth ?? this.tenuresInMonth,
        );

    factory InterestDataModel.fromJson(Map<String, dynamic> json) => InterestDataModel(
        firstName: json["First Name"],
        lastName: json["Last Name"],
        annualInterestRate: json["Annual Interest Rate"],
        principalAmount: json["Principal Amount"],
        tenuresInMonth: json["Tenures in Month"],
    );

    Map<String, dynamic> toJson() => {
        "First Name": firstName,
        "Last Name": lastName,
        "Annual Interest Rate": annualInterestRate,
        "Principal Amount": principalAmount,
        "Tenures in Month": tenuresInMonth,
    };
}
