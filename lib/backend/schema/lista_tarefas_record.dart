import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'lista_tarefas_record.g.dart';

abstract class ListaTarefasRecord
    implements Built<ListaTarefasRecord, ListaTarefasRecordBuilder> {
  static Serializer<ListaTarefasRecord> get serializer =>
      _$listaTarefasRecordSerializer;

  @nullable
  String get titulo;

  @nullable
  String get descricao;

  @nullable
  DateTime get data;

  @nullable
  bool get status;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ListaTarefasRecordBuilder builder) => builder
    ..titulo = ''
    ..descricao = ''
    ..status = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('listaTarefas');

  static Stream<ListaTarefasRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ListaTarefasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  ListaTarefasRecord._();
  factory ListaTarefasRecord(
          [void Function(ListaTarefasRecordBuilder) updates]) =
      _$ListaTarefasRecord;

  static ListaTarefasRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createListaTarefasRecordData({
  String titulo,
  String descricao,
  DateTime data,
  bool status,
}) =>
    serializers.toFirestore(
        ListaTarefasRecord.serializer,
        ListaTarefasRecord((l) => l
          ..titulo = titulo
          ..descricao = descricao
          ..data = data
          ..status = status));
