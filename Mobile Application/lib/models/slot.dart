class Slot {
  final int id;
  final String start;
  final String end;
  final int cpty;

  const Slot({
    required this.id,
    required this.start,
    required this.end,
    required this.cpty,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json["Slotid"] as int,
      start: json["StartTime"] as String,
      end: json["EndTime"] as String,
      cpty: json["Capacity"] as int,
    );
  }
}
