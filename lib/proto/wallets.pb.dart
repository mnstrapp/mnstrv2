// This is a generated file - do not edit.
//
// Generated from wallets.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'transactions.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Wallet extends $pb.GeneratedMessage {
  factory Wallet({
    $core.String? id,
    $core.String? userId,
    $core.int? coins,
    $core.Iterable<$1.Transaction>? transactions,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (coins != null) result.coins = coins;
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  Wallet._();

  factory Wallet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Wallet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Wallet',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aI(3, _omitFieldNames ? '' : 'coins')
    ..pPM<$1.Transaction>(4, _omitFieldNames ? '' : 'transactions',
        subBuilder: $1.Transaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Wallet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Wallet copyWith(void Function(Wallet) updates) =>
      super.copyWith((message) => updates(message as Wallet)) as Wallet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Wallet create() => Wallet._();
  @$core.override
  Wallet createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Wallet getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Wallet>(create);
  static Wallet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get coins => $_getIZ(2);
  @$pb.TagNumber(3)
  set coins($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCoins() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoins() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Transaction> get transactions => $_getList(3);
}

class GetWalletRequest extends $pb.GeneratedMessage {
  factory GetWalletRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetWalletRequest._();

  factory GetWalletRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletRequest copyWith(void Function(GetWalletRequest) updates) =>
      super.copyWith((message) => updates(message as GetWalletRequest))
          as GetWalletRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletRequest create() => GetWalletRequest._();
  @$core.override
  GetWalletRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetWalletRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWalletRequest>(create);
  static GetWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetWalletResponse extends $pb.GeneratedMessage {
  factory GetWalletResponse({
    Wallet? wallet,
  }) {
    final result = create();
    if (wallet != null) result.wallet = wallet;
    return result;
  }

  GetWalletResponse._();

  factory GetWalletResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Wallet>(1, _omitFieldNames ? '' : 'wallet', subBuilder: Wallet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletResponse copyWith(void Function(GetWalletResponse) updates) =>
      super.copyWith((message) => updates(message as GetWalletResponse))
          as GetWalletResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletResponse create() => GetWalletResponse._();
  @$core.override
  GetWalletResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetWalletResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWalletResponse>(create);
  static GetWalletResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Wallet get wallet => $_getN(0);
  @$pb.TagNumber(1)
  set wallet(Wallet value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWallet() => $_has(0);
  @$pb.TagNumber(1)
  void clearWallet() => $_clearField(1);
  @$pb.TagNumber(1)
  Wallet ensureWallet() => $_ensure(0);
}

class ListWalletsRequest extends $pb.GeneratedMessage {
  factory ListWalletsRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? userId,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (userId != null) result.userId = userId;
    return result;
  }

  ListWalletsRequest._();

  factory ListWalletsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListWalletsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWalletsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListWalletsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListWalletsRequest copyWith(void Function(ListWalletsRequest) updates) =>
      super.copyWith((message) => updates(message as ListWalletsRequest))
          as ListWalletsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWalletsRequest create() => ListWalletsRequest._();
  @$core.override
  ListWalletsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListWalletsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListWalletsRequest>(create);
  static ListWalletsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);
}

class ListWalletsResponse extends $pb.GeneratedMessage {
  factory ListWalletsResponse({
    $core.Iterable<Wallet>? wallets,
  }) {
    final result = create();
    if (wallets != null) result.wallets.addAll(wallets);
    return result;
  }

  ListWalletsResponse._();

  factory ListWalletsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListWalletsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWalletsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..pPM<Wallet>(1, _omitFieldNames ? '' : 'wallets',
        subBuilder: Wallet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListWalletsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListWalletsResponse copyWith(void Function(ListWalletsResponse) updates) =>
      super.copyWith((message) => updates(message as ListWalletsResponse))
          as ListWalletsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWalletsResponse create() => ListWalletsResponse._();
  @$core.override
  ListWalletsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListWalletsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListWalletsResponse>(create);
  static ListWalletsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Wallet> get wallets => $_getList(0);
}

class StreamWalletsRequest extends $pb.GeneratedMessage {
  factory StreamWalletsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  StreamWalletsRequest._();

  factory StreamWalletsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamWalletsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamWalletsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamWalletsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamWalletsRequest copyWith(void Function(StreamWalletsRequest) updates) =>
      super.copyWith((message) => updates(message as StreamWalletsRequest))
          as StreamWalletsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamWalletsRequest create() => StreamWalletsRequest._();
  @$core.override
  StreamWalletsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamWalletsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamWalletsRequest>(create);
  static StreamWalletsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class StreamWalletsResponse extends $pb.GeneratedMessage {
  factory StreamWalletsResponse({
    Wallet? wallet,
  }) {
    final result = create();
    if (wallet != null) result.wallet = wallet;
    return result;
  }

  StreamWalletsResponse._();

  factory StreamWalletsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamWalletsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamWalletsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Wallet>(1, _omitFieldNames ? '' : 'wallet', subBuilder: Wallet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamWalletsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamWalletsResponse copyWith(
          void Function(StreamWalletsResponse) updates) =>
      super.copyWith((message) => updates(message as StreamWalletsResponse))
          as StreamWalletsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamWalletsResponse create() => StreamWalletsResponse._();
  @$core.override
  StreamWalletsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamWalletsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamWalletsResponse>(create);
  static StreamWalletsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Wallet get wallet => $_getN(0);
  @$pb.TagNumber(1)
  set wallet(Wallet value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWallet() => $_has(0);
  @$pb.TagNumber(1)
  void clearWallet() => $_clearField(1);
  @$pb.TagNumber(1)
  Wallet ensureWallet() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
