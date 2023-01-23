class Member {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String cNIC;

  const Member({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.cNIC,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["MemberId"] as int,
      name: json["Name"] as String,
      email: json["Email"] as String,
      gender: json["Gender"] as String,
      cNIC: json["CNIC"] as String,
    );
  }

  void showMembers() {
    print(name + email + gender);
  }
}
