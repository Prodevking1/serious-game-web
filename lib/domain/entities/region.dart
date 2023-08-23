import 'package:flame_game/domain/entities/party.dart';
import 'package:flutter/material.dart';

class Region {
  int? id;
  String name;
  String? description;
  Party? party;
  Offset? offset;
  int? partyId;

  Region({
    this.id,
    required this.name,
    this.description,
    this.party,
    this.offset,
    this.partyId,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      party: Party.fromJson(json),
      offset: Offset(json['offset_dx'], json['offset_dy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      // 'party': party.toJson(),
      'offset_dy': offset!.dx,
      'offset_dx': offset!.dy,
      'party_id': partyId,
    };
  }
}
