import 'package:flame_game/domain/entities/party.dart';
import 'package:flutter/material.dart';

class Region {
  int? id;
  String name;
  String? description;
  Party party;
  Offset? offset;

  Region({
    this.id,
    required this.name,
    this.description,
    required this.party,
    this.offset,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      party: Party.fromJson(json['party']),
      offset: json['offset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'party': party.toJson(),
      'offset': offset,
    };
  }
}
