// This is a generated file - do not edit.
//
// Generated from users.proto.

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

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'phone', '17': true},
    {'1': 'experience_level', '3': 5, '4': 1, '5': 5, '10': 'experienceLevel'},
    {
      '1': 'experience_points',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'experiencePoints'
    },
    {
      '1': 'experience_to_next_level',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'experienceToNextLevel'
    },
    {'1': 'coins', '3': 8, '4': 1, '5': 5, '10': 'coins'},
    {
      '1': 'mnstrs',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstrs'
    },
    {
      '1': 'wallet',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Wallet',
      '9': 1,
      '10': 'wallet',
      '17': true
    },
  ],
  '8': [
    {'1': '_phone'},
    {'1': '_wallet'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW'
    '1lEhQKBWVtYWlsGAMgASgJUgVlbWFpbBIZCgVwaG9uZRgEIAEoCUgAUgVwaG9uZYgBARIpChBl'
    'eHBlcmllbmNlX2xldmVsGAUgASgFUg9leHBlcmllbmNlTGV2ZWwSKwoRZXhwZXJpZW5jZV9wb2'
    'ludHMYBiABKAVSEGV4cGVyaWVuY2VQb2ludHMSNwoYZXhwZXJpZW5jZV90b19uZXh0X2xldmVs'
    'GAcgASgFUhVleHBlcmllbmNlVG9OZXh0TGV2ZWwSFAoFY29pbnMYCCABKAVSBWNvaW5zEiYKBm'
    '1uc3RycxgJIAMoCzIOLm1uc3RydjIuTW5zdHJSBm1uc3RycxIsCgZ3YWxsZXQYCiABKAsyDy5t'
    'bnN0cnYyLldhbGxldEgBUgZ3YWxsZXSIAQFCCAoGX3Bob25lQgkKB193YWxsZXQ=');

@$core.Deprecated('Use myUserRequestDescriptor instead')
const MyUserRequest$json = {
  '1': 'MyUserRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `MyUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myUserRequestDescriptor = $convert
    .base64Decode('Cg1NeVVzZXJSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use myUserResponseDescriptor instead')
const MyUserResponse$json = {
  '1': 'MyUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.mnstrv2.User', '10': 'user'},
  ],
};

/// Descriptor for `MyUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myUserResponseDescriptor = $convert.base64Decode(
    'Cg5NeVVzZXJSZXNwb25zZRIhCgR1c2VyGAEgASgLMg0ubW5zdHJ2Mi5Vc2VyUgR1c2Vy');
