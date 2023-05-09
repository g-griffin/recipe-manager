// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IndexStore on _IndexStore, Store {
  late final _$_indicesAtom =
      Atom(name: '_IndexStore._indices', context: context);

  @override
  List<Index> get _indices {
    _$_indicesAtom.reportRead();
    return super._indices;
  }

  @override
  set _indices(List<Index> value) {
    _$_indicesAtom.reportWrite(value, super._indices, () {
      super._indices = value;
    });
  }

  late final _$loadIndicesAsyncAction =
      AsyncAction('_IndexStore.loadIndices', context: context);

  @override
  Future<void> loadIndices() {
    return _$loadIndicesAsyncAction.run(() => super.loadIndices());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
