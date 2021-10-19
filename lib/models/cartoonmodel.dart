import 'dart:convert';
//17.10.2021s
class CartoonModel {
  final String name;
  final String cover;
  final String pdf;
  CartoonModel({
    this.name,
    this.cover,
    this.pdf,
  });

  CartoonModel copyWith({
    String name,
    String cover,
    String pdf,
  }) {
    return CartoonModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
      'pdf': pdf,
    };
  }

  factory CartoonModel.fromMap(Map<String, dynamic> map) {
    return CartoonModel(
      name: map['name'],
      cover: map['cover'],
      pdf: map['pdf'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartoonModel.fromJson(String source) =>
      CartoonModel.fromMap(json.decode(source));

  @override
  String toString() => 'CartoonModel(name: $name, cover: $cover, pdf: $pdf)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartoonModel &&
        other.name == name &&
        other.cover == cover &&
        other.pdf == pdf;
  }

  @override
  int get hashCode => name.hashCode ^ cover.hashCode ^ pdf.hashCode;
}
