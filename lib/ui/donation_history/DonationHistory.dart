class DonationHistory {
  final String donationId;
  final String patName;
  final String? hospital;
  final String phone;

  DonationHistory({
    required this.donationId,
    required this.patName,
    this.hospital,
    required this.phone,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      donationId: json['donation_id'],
      patName: json['pat_name'],
      hospital: json['hospital'],
      phone: json['phone'],
    );
  }
}
