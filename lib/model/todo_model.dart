import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TodoModel {
  String? id;
  final String? nome;
  final bool status;
  final DateTime? criadoEm;

  TodoModel({
    this.id,
    this.nome,
    this.status = false,
    this.criadoEm,
  });

  // Construtor Factory para converter JSON em objeto Dart
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    try {
      return TodoModel(
        id: json['id'],
        nome: json['nome'],
        status: json['status'],
        criadoEm: DateTime.fromMicrosecondsSinceEpoch(
          (json['criadoEm'] as Timestamp).microsecondsSinceEpoch,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
  // Método para converter objeto Dart em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'status': status,
      'criadoEm': criadoEm,
    };
  }

  TodoModel copyWith({
    String? id,
    String? nome,
    bool? status,
    DateTime? criadoEm,
  }) {
    return TodoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      status: status ?? this.status,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }
  Factory TodoModel.FromFirestore(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
  SnapshotOptions? options,
 ) {
   final data = snapshot.data();
   return TodoModel(
     id: data!['id'],
     nome: data! ['id'],
     status: data['status'],
     criadoEm: data['criadorEm']);
 }
}

 