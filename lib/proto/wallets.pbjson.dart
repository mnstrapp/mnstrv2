// This is a generated file - do not edit.
//
// Generated from wallets.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use walletDescriptor instead')
const Wallet$json = {
  '1': 'Wallet',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'coins', '3': 3, '4': 1, '5': 5, '10': 'coins'},
    {
      '1': 'transactions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Transaction',
      '10': 'transactions'
    },
  ],
};

/// Descriptor for `Wallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletDescriptor = $convert.base64Decode(
    'CgZXYWxsZXQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIUCgVjb2'
    'lucxgDIAEoBVIFY29pbnMSOAoMdHJhbnNhY3Rpb25zGAQgAygLMhQubW5zdHJ2Mi5UcmFuc2Fj'
    'dGlvblIMdHJhbnNhY3Rpb25z');

@$core.Deprecated('Use getWalletRequestDescriptor instead')
const GetWalletRequest$json = {
  '1': 'GetWalletRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletRequestDescriptor =
    $convert.base64Decode('ChBHZXRXYWxsZXRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use getWalletResponseDescriptor instead')
const GetWalletResponse$json = {
  '1': 'GetWalletResponse',
  '2': [
    {
      '1': 'wallet',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Wallet',
      '10': 'wallet'
    },
  ],
};

/// Descriptor for `GetWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletResponseDescriptor = $convert.base64Decode(
    'ChFHZXRXYWxsZXRSZXNwb25zZRInCgZ3YWxsZXQYASABKAsyDy5tbnN0cnYyLldhbGxldFIGd2'
    'FsbGV0');

@$core.Deprecated('Use listWalletsRequestDescriptor instead')
const ListWalletsRequest$json = {
  '1': 'ListWalletsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {
      '1': 'user_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'userId',
      '17': true
    },
  ],
  '8': [
    {'1': '_user_id'},
  ],
};

/// Descriptor for `ListWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listWalletsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0V2FsbGV0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBV'
    'IFbGltaXQSHAoHdXNlcl9pZBgDIAEoCUgAUgZ1c2VySWSIAQFCCgoIX3VzZXJfaWQ=');

@$core.Deprecated('Use listWalletsResponseDescriptor instead')
const ListWalletsResponse$json = {
  '1': 'ListWalletsResponse',
  '2': [
    {
      '1': 'wallets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Wallet',
      '10': 'wallets'
    },
  ],
};

/// Descriptor for `ListWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listWalletsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0V2FsbGV0c1Jlc3BvbnNlEikKB3dhbGxldHMYASADKAsyDy5tbnN0cnYyLldhbGxldF'
    'IHd2FsbGV0cw==');

@$core.Deprecated('Use streamWalletsRequestDescriptor instead')
const StreamWalletsRequest$json = {
  '1': 'StreamWalletsRequest',
  '2': [
    {
      '1': 'user_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'userId',
      '17': true
    },
  ],
  '8': [
    {'1': '_user_id'},
  ],
};

/// Descriptor for `StreamWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamWalletsRequestDescriptor = $convert.base64Decode(
    'ChRTdHJlYW1XYWxsZXRzUmVxdWVzdBIcCgd1c2VyX2lkGAEgASgJSABSBnVzZXJJZIgBAUIKCg'
    'hfdXNlcl9pZA==');

@$core.Deprecated('Use streamWalletsResponseDescriptor instead')
const StreamWalletsResponse$json = {
  '1': 'StreamWalletsResponse',
  '2': [
    {
      '1': 'wallet',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Wallet',
      '10': 'wallet'
    },
  ],
};

/// Descriptor for `StreamWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamWalletsResponseDescriptor = $convert.base64Decode(
    'ChVTdHJlYW1XYWxsZXRzUmVzcG9uc2USJwoGd2FsbGV0GAEgASgLMg8ubW5zdHJ2Mi5XYWxsZX'
    'RSBndhbGxldA==');
