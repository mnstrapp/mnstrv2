// This is a generated file - do not edit.
//
// Generated from mnstr.proto.

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

@$core.Deprecated('Use mnstrOrderByDescriptor instead')
const MnstrOrderBy$json = {
  '1': 'MnstrOrderBy',
  '2': [
    {'1': 'MNSTR_ORDER_BY_UNSPECIFIED', '2': 0},
    {'1': 'MNSTR_ORDER_BY_CREATED_AT', '2': 1},
    {'1': 'MNSTR_ORDER_BY_UPDATED_AT', '2': 2},
    {'1': 'MNSTR_ORDER_BY_NAME', '2': 3},
    {'1': 'MNSTR_ORDER_BY_LEVEL', '2': 4},
    {'1': 'MNSTR_ORDER_BY_EXPERIENCE', '2': 5},
    {'1': 'MNSTR_ORDER_BY_HEALTH', '2': 6},
    {'1': 'MNSTR_ORDER_BY_ATTACK', '2': 7},
    {'1': 'MNSTR_ORDER_BY_DEFENSE', '2': 8},
    {'1': 'MNSTR_ORDER_BY_SPEED', '2': 9},
    {'1': 'MNSTR_ORDER_BY_INTELLIGENCE', '2': 10},
    {'1': 'MNSTR_ORDER_BY_MAGIC', '2': 11},
  ],
};

/// Descriptor for `MnstrOrderBy`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mnstrOrderByDescriptor = $convert.base64Decode(
    'CgxNbnN0ck9yZGVyQnkSHgoaTU5TVFJfT1JERVJfQllfVU5TUEVDSUZJRUQQABIdChlNTlNUUl'
    '9PUkRFUl9CWV9DUkVBVEVEX0FUEAESHQoZTU5TVFJfT1JERVJfQllfVVBEQVRFRF9BVBACEhcK'
    'E01OU1RSX09SREVSX0JZX05BTUUQAxIYChRNTlNUUl9PUkRFUl9CWV9MRVZFTBAEEh0KGU1OU1'
    'RSX09SREVSX0JZX0VYUEVSSUVOQ0UQBRIZChVNTlNUUl9PUkRFUl9CWV9IRUFMVEgQBhIZChVN'
    'TlNUUl9PUkRFUl9CWV9BVFRBQ0sQBxIaChZNTlNUUl9PUkRFUl9CWV9ERUZFTlNFEAgSGAoUTU'
    '5TVFJfT1JERVJfQllfU1BFRUQQCRIfChtNTlNUUl9PUkRFUl9CWV9JTlRFTExJR0VOQ0UQChIY'
    'ChRNTlNUUl9PUkRFUl9CWV9NQUdJQxAL');

@$core.Deprecated('Use mnstrOrderDirectionDescriptor instead')
const MnstrOrderDirection$json = {
  '1': 'MnstrOrderDirection',
  '2': [
    {'1': 'MNSTR_ORDER_DIRECTION_UNSPECIFIED', '2': 0},
    {'1': 'MNSTR_ORDER_DIRECTION_ASC', '2': 1},
    {'1': 'MNSTR_ORDER_DIRECTION_DESC', '2': 2},
  ],
};

/// Descriptor for `MnstrOrderDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mnstrOrderDirectionDescriptor = $convert.base64Decode(
    'ChNNbnN0ck9yZGVyRGlyZWN0aW9uEiUKIU1OU1RSX09SREVSX0RJUkVDVElPTl9VTlNQRUNJRk'
    'lFRBAAEh0KGU1OU1RSX09SREVSX0RJUkVDVElPTl9BU0MQARIeChpNTlNUUl9PUkRFUl9ESVJF'
    'Q1RJT05fREVTQxAC');

@$core.Deprecated('Use mnstrDescriptor instead')
const Mnstr$json = {
  '1': 'Mnstr',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'mnstr_name', '3': 3, '4': 1, '5': 9, '10': 'mnstrName'},
    {
      '1': 'mnstr_description',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'mnstrDescription'
    },
    {'1': 'mnstr_qr_code', '3': 5, '4': 1, '5': 9, '10': 'mnstrQrCode'},
    {'1': 'current_level', '3': 6, '4': 1, '5': 5, '10': 'currentLevel'},
    {
      '1': 'current_experience',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'currentExperience'
    },
    {'1': 'current_health', '3': 8, '4': 1, '5': 5, '10': 'currentHealth'},
    {'1': 'max_health', '3': 9, '4': 1, '5': 5, '10': 'maxHealth'},
    {'1': 'current_attack', '3': 10, '4': 1, '5': 5, '10': 'currentAttack'},
    {'1': 'max_attack', '3': 11, '4': 1, '5': 5, '10': 'maxAttack'},
    {'1': 'current_defense', '3': 12, '4': 1, '5': 5, '10': 'currentDefense'},
    {'1': 'max_defense', '3': 13, '4': 1, '5': 5, '10': 'maxDefense'},
    {'1': 'current_speed', '3': 14, '4': 1, '5': 5, '10': 'currentSpeed'},
    {'1': 'max_speed', '3': 15, '4': 1, '5': 5, '10': 'maxSpeed'},
    {
      '1': 'current_intelligence',
      '3': 16,
      '4': 1,
      '5': 5,
      '10': 'currentIntelligence'
    },
    {'1': 'max_intelligence', '3': 17, '4': 1, '5': 5, '10': 'maxIntelligence'},
    {'1': 'current_magic', '3': 18, '4': 1, '5': 5, '10': 'currentMagic'},
    {'1': 'max_magic', '3': 19, '4': 1, '5': 5, '10': 'maxMagic'},
    {
      '1': 'experience_to_next_level',
      '3': 20,
      '4': 1,
      '5': 5,
      '10': 'experienceToNextLevel'
    },
  ],
};

/// Descriptor for `Mnstr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mnstrDescriptor = $convert.base64Decode(
    'CgVNbnN0chIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCm1uc3'
    'RyX25hbWUYAyABKAlSCW1uc3RyTmFtZRIrChFtbnN0cl9kZXNjcmlwdGlvbhgEIAEoCVIQbW5z'
    'dHJEZXNjcmlwdGlvbhIiCg1tbnN0cl9xcl9jb2RlGAUgASgJUgttbnN0clFyQ29kZRIjCg1jdX'
    'JyZW50X2xldmVsGAYgASgFUgxjdXJyZW50TGV2ZWwSLQoSY3VycmVudF9leHBlcmllbmNlGAcg'
    'ASgFUhFjdXJyZW50RXhwZXJpZW5jZRIlCg5jdXJyZW50X2hlYWx0aBgIIAEoBVINY3VycmVudE'
    'hlYWx0aBIdCgptYXhfaGVhbHRoGAkgASgFUgltYXhIZWFsdGgSJQoOY3VycmVudF9hdHRhY2sY'
    'CiABKAVSDWN1cnJlbnRBdHRhY2sSHQoKbWF4X2F0dGFjaxgLIAEoBVIJbWF4QXR0YWNrEicKD2'
    'N1cnJlbnRfZGVmZW5zZRgMIAEoBVIOY3VycmVudERlZmVuc2USHwoLbWF4X2RlZmVuc2UYDSAB'
    'KAVSCm1heERlZmVuc2USIwoNY3VycmVudF9zcGVlZBgOIAEoBVIMY3VycmVudFNwZWVkEhsKCW'
    '1heF9zcGVlZBgPIAEoBVIIbWF4U3BlZWQSMQoUY3VycmVudF9pbnRlbGxpZ2VuY2UYECABKAVS'
    'E2N1cnJlbnRJbnRlbGxpZ2VuY2USKQoQbWF4X2ludGVsbGlnZW5jZRgRIAEoBVIPbWF4SW50ZW'
    'xsaWdlbmNlEiMKDWN1cnJlbnRfbWFnaWMYEiABKAVSDGN1cnJlbnRNYWdpYxIbCgltYXhfbWFn'
    'aWMYEyABKAVSCG1heE1hZ2ljEjcKGGV4cGVyaWVuY2VfdG9fbmV4dF9sZXZlbBgUIAEoBVIVZX'
    'hwZXJpZW5jZVRvTmV4dExldmVs');

@$core.Deprecated('Use mnstrInputDescriptor instead')
const MnstrInput$json = {
  '1': 'MnstrInput',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {
      '1': 'mnstr_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'mnstrName',
      '17': true
    },
    {
      '1': 'mnstr_description',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'mnstrDescription',
      '17': true
    },
    {
      '1': 'mnstr_qr_code',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'mnstrQrCode',
      '17': true
    },
    {
      '1': 'current_level',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'currentLevel',
      '17': true
    },
    {
      '1': 'current_experience',
      '3': 10,
      '4': 1,
      '5': 5,
      '9': 5,
      '10': 'currentExperience',
      '17': true
    },
    {
      '1': 'current_health',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 6,
      '10': 'currentHealth',
      '17': true
    },
    {
      '1': 'max_health',
      '3': 12,
      '4': 1,
      '5': 5,
      '9': 7,
      '10': 'maxHealth',
      '17': true
    },
    {
      '1': 'current_attack',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 8,
      '10': 'currentAttack',
      '17': true
    },
    {
      '1': 'max_attack',
      '3': 14,
      '4': 1,
      '5': 5,
      '9': 9,
      '10': 'maxAttack',
      '17': true
    },
    {
      '1': 'current_defense',
      '3': 15,
      '4': 1,
      '5': 5,
      '9': 10,
      '10': 'currentDefense',
      '17': true
    },
    {
      '1': 'max_defense',
      '3': 16,
      '4': 1,
      '5': 5,
      '9': 11,
      '10': 'maxDefense',
      '17': true
    },
    {
      '1': 'current_speed',
      '3': 17,
      '4': 1,
      '5': 5,
      '9': 12,
      '10': 'currentSpeed',
      '17': true
    },
    {
      '1': 'max_speed',
      '3': 18,
      '4': 1,
      '5': 5,
      '9': 13,
      '10': 'maxSpeed',
      '17': true
    },
    {
      '1': 'current_intelligence',
      '3': 19,
      '4': 1,
      '5': 5,
      '9': 14,
      '10': 'currentIntelligence',
      '17': true
    },
    {
      '1': 'max_intelligence',
      '3': 20,
      '4': 1,
      '5': 5,
      '9': 15,
      '10': 'maxIntelligence',
      '17': true
    },
    {
      '1': 'current_magic',
      '3': 21,
      '4': 1,
      '5': 5,
      '9': 16,
      '10': 'currentMagic',
      '17': true
    },
    {
      '1': 'max_magic',
      '3': 22,
      '4': 1,
      '5': 5,
      '9': 17,
      '10': 'maxMagic',
      '17': true
    },
  ],
  '8': [
    {'1': '_id'},
    {'1': '_mnstr_name'},
    {'1': '_mnstr_description'},
    {'1': '_mnstr_qr_code'},
    {'1': '_current_level'},
    {'1': '_current_experience'},
    {'1': '_current_health'},
    {'1': '_max_health'},
    {'1': '_current_attack'},
    {'1': '_max_attack'},
    {'1': '_current_defense'},
    {'1': '_max_defense'},
    {'1': '_current_speed'},
    {'1': '_max_speed'},
    {'1': '_current_intelligence'},
    {'1': '_max_intelligence'},
    {'1': '_current_magic'},
    {'1': '_max_magic'},
  ],
};

/// Descriptor for `MnstrInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mnstrInputDescriptor = $convert.base64Decode(
    'CgpNbnN0cklucHV0EhMKAmlkGAEgASgJSABSAmlkiAEBEiIKCm1uc3RyX25hbWUYAyABKAlIAV'
    'IJbW5zdHJOYW1liAEBEjAKEW1uc3RyX2Rlc2NyaXB0aW9uGAQgASgJSAJSEG1uc3RyRGVzY3Jp'
    'cHRpb26IAQESJwoNbW5zdHJfcXJfY29kZRgFIAEoCUgDUgttbnN0clFyQ29kZYgBARIoCg1jdX'
    'JyZW50X2xldmVsGAkgASgFSARSDGN1cnJlbnRMZXZlbIgBARIyChJjdXJyZW50X2V4cGVyaWVu'
    'Y2UYCiABKAVIBVIRY3VycmVudEV4cGVyaWVuY2WIAQESKgoOY3VycmVudF9oZWFsdGgYCyABKA'
    'VIBlINY3VycmVudEhlYWx0aIgBARIiCgptYXhfaGVhbHRoGAwgASgFSAdSCW1heEhlYWx0aIgB'
    'ARIqCg5jdXJyZW50X2F0dGFjaxgNIAEoBUgIUg1jdXJyZW50QXR0YWNriAEBEiIKCm1heF9hdH'
    'RhY2sYDiABKAVICVIJbWF4QXR0YWNriAEBEiwKD2N1cnJlbnRfZGVmZW5zZRgPIAEoBUgKUg5j'
    'dXJyZW50RGVmZW5zZYgBARIkCgttYXhfZGVmZW5zZRgQIAEoBUgLUgptYXhEZWZlbnNliAEBEi'
    'gKDWN1cnJlbnRfc3BlZWQYESABKAVIDFIMY3VycmVudFNwZWVkiAEBEiAKCW1heF9zcGVlZBgS'
    'IAEoBUgNUghtYXhTcGVlZIgBARI2ChRjdXJyZW50X2ludGVsbGlnZW5jZRgTIAEoBUgOUhNjdX'
    'JyZW50SW50ZWxsaWdlbmNliAEBEi4KEG1heF9pbnRlbGxpZ2VuY2UYFCABKAVID1IPbWF4SW50'
    'ZWxsaWdlbmNliAEBEigKDWN1cnJlbnRfbWFnaWMYFSABKAVIEFIMY3VycmVudE1hZ2ljiAEBEi'
    'AKCW1heF9tYWdpYxgWIAEoBUgRUghtYXhNYWdpY4gBAUIFCgNfaWRCDQoLX21uc3RyX25hbWVC'
    'FAoSX21uc3RyX2Rlc2NyaXB0aW9uQhAKDl9tbnN0cl9xcl9jb2RlQhAKDl9jdXJyZW50X2xldm'
    'VsQhUKE19jdXJyZW50X2V4cGVyaWVuY2VCEQoPX2N1cnJlbnRfaGVhbHRoQg0KC19tYXhfaGVh'
    'bHRoQhEKD19jdXJyZW50X2F0dGFja0INCgtfbWF4X2F0dGFja0ISChBfY3VycmVudF9kZWZlbn'
    'NlQg4KDF9tYXhfZGVmZW5zZUIQCg5fY3VycmVudF9zcGVlZEIMCgpfbWF4X3NwZWVkQhcKFV9j'
    'dXJyZW50X2ludGVsbGlnZW5jZUITChFfbWF4X2ludGVsbGlnZW5jZUIQCg5fY3VycmVudF9tYW'
    'dpY0IMCgpfbWF4X21hZ2lj');

@$core.Deprecated('Use batchMnstrInputDescriptor instead')
const BatchMnstrInput$json = {
  '1': 'BatchMnstrInput',
  '2': [
    {
      '1': 'mnstrs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.MnstrInput',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `BatchMnstrInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchMnstrInputDescriptor = $convert.base64Decode(
    'Cg9CYXRjaE1uc3RySW5wdXQSKwoGbW5zdHJzGAEgAygLMhMubW5zdHJ2Mi5NbnN0cklucHV0Ug'
    'ZtbnN0cnM=');

@$core.Deprecated('Use listMnstrsRequestDescriptor instead')
const ListMnstrsRequest$json = {
  '1': 'ListMnstrsRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'order_by',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.mnstrv2.MnstrOrderBy',
      '9': 0,
      '10': 'orderBy',
      '17': true
    },
    {
      '1': 'order_direction',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.mnstrv2.MnstrOrderDirection',
      '9': 1,
      '10': 'orderDirection',
      '17': true
    },
  ],
  '8': [
    {'1': '_order_by'},
    {'1': '_order_direction'},
  ],
};

/// Descriptor for `ListMnstrsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMnstrsRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0TW5zdHJzUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SNQoIb3JkZXJfYnkYAi'
    'ABKA4yFS5tbnN0cnYyLk1uc3RyT3JkZXJCeUgAUgdvcmRlckJ5iAEBEkoKD29yZGVyX2RpcmVj'
    'dGlvbhgDIAEoDjIcLm1uc3RydjIuTW5zdHJPcmRlckRpcmVjdGlvbkgBUg5vcmRlckRpcmVjdG'
    'lvbogBAUILCglfb3JkZXJfYnlCEgoQX29yZGVyX2RpcmVjdGlvbg==');

@$core.Deprecated('Use listMnstrsResponseDescriptor instead')
const ListMnstrsResponse$json = {
  '1': 'ListMnstrsResponse',
  '2': [
    {
      '1': 'mnstrs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `ListMnstrsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMnstrsResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0TW5zdHJzUmVzcG9uc2USJgoGbW5zdHJzGAEgAygLMg4ubW5zdHJ2Mi5NbnN0clIGbW'
    '5zdHJz');

@$core.Deprecated('Use getMnstrByQrCodeRequestDescriptor instead')
const GetMnstrByQrCodeRequest$json = {
  '1': 'GetMnstrByQrCodeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'mnstr_qr_code', '3': 2, '4': 1, '5': 9, '10': 'mnstrQrCode'},
  ],
};

/// Descriptor for `GetMnstrByQrCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMnstrByQrCodeRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRNbnN0ckJ5UXJDb2RlUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SIgoNbW5zdH'
        'JfcXJfY29kZRgCIAEoCVILbW5zdHJRckNvZGU=');

@$core.Deprecated('Use getMnstrByQrCodeResponseDescriptor instead')
const GetMnstrByQrCodeResponse$json = {
  '1': 'GetMnstrByQrCodeResponse',
  '2': [
    {
      '1': 'mnstr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstr'
    },
  ],
};

/// Descriptor for `GetMnstrByQrCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMnstrByQrCodeResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRNbnN0ckJ5UXJDb2RlUmVzcG9uc2USJAoFbW5zdHIYASABKAsyDi5tbnN0cnYyLk1uc3'
        'RyUgVtbnN0cg==');

@$core.Deprecated('Use collectMnstrRequestDescriptor instead')
const CollectMnstrRequest$json = {
  '1': 'CollectMnstrRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'mnstr_qr_code', '3': 2, '4': 1, '5': 9, '10': 'mnstrQrCode'},
  ],
};

/// Descriptor for `CollectMnstrRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectMnstrRequestDescriptor = $convert.base64Decode(
    'ChNDb2xsZWN0TW5zdHJSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIiCg1tbnN0cl9xcl'
    '9jb2RlGAIgASgJUgttbnN0clFyQ29kZQ==');

@$core.Deprecated('Use collectMnstrResponseDescriptor instead')
const CollectMnstrResponse$json = {
  '1': 'CollectMnstrResponse',
  '2': [
    {
      '1': 'mnstr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstr'
    },
  ],
};

/// Descriptor for `CollectMnstrResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List collectMnstrResponseDescriptor = $convert.base64Decode(
    'ChRDb2xsZWN0TW5zdHJSZXNwb25zZRIkCgVtbnN0chgBIAEoCzIOLm1uc3RydjIuTW5zdHJSBW'
    '1uc3Ry');

@$core.Deprecated('Use createMnstrRequestDescriptor instead')
const CreateMnstrRequest$json = {
  '1': 'CreateMnstrRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'mnstr_name',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'mnstrName',
      '17': true
    },
    {
      '1': 'mnstr_description',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'mnstrDescription',
      '17': true
    },
    {'1': 'mnstr_qr_code', '3': 4, '4': 1, '5': 9, '10': 'mnstrQrCode'},
    {
      '1': 'current_health',
      '3': 5,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'currentHealth',
      '17': true
    },
    {
      '1': 'max_health',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 3,
      '10': 'maxHealth',
      '17': true
    },
    {
      '1': 'current_attack',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'currentAttack',
      '17': true
    },
    {
      '1': 'max_attack',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 5,
      '10': 'maxAttack',
      '17': true
    },
    {
      '1': 'current_defense',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 6,
      '10': 'currentDefense',
      '17': true
    },
    {
      '1': 'max_defense',
      '3': 10,
      '4': 1,
      '5': 5,
      '9': 7,
      '10': 'maxDefense',
      '17': true
    },
    {
      '1': 'current_speed',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 8,
      '10': 'currentSpeed',
      '17': true
    },
    {
      '1': 'max_speed',
      '3': 12,
      '4': 1,
      '5': 5,
      '9': 9,
      '10': 'maxSpeed',
      '17': true
    },
    {
      '1': 'current_intelligence',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 10,
      '10': 'currentIntelligence',
      '17': true
    },
    {
      '1': 'max_intelligence',
      '3': 14,
      '4': 1,
      '5': 5,
      '9': 11,
      '10': 'maxIntelligence',
      '17': true
    },
    {
      '1': 'current_magic',
      '3': 15,
      '4': 1,
      '5': 5,
      '9': 12,
      '10': 'currentMagic',
      '17': true
    },
    {
      '1': 'max_magic',
      '3': 16,
      '4': 1,
      '5': 5,
      '9': 13,
      '10': 'maxMagic',
      '17': true
    },
  ],
  '8': [
    {'1': '_mnstr_name'},
    {'1': '_mnstr_description'},
    {'1': '_current_health'},
    {'1': '_max_health'},
    {'1': '_current_attack'},
    {'1': '_max_attack'},
    {'1': '_current_defense'},
    {'1': '_max_defense'},
    {'1': '_current_speed'},
    {'1': '_max_speed'},
    {'1': '_current_intelligence'},
    {'1': '_max_intelligence'},
    {'1': '_current_magic'},
    {'1': '_max_magic'},
  ],
};

/// Descriptor for `CreateMnstrRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMnstrRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVNbnN0clJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEiIKCm1uc3RyX25hbW'
    'UYAiABKAlIAFIJbW5zdHJOYW1liAEBEjAKEW1uc3RyX2Rlc2NyaXB0aW9uGAMgASgJSAFSEG1u'
    'c3RyRGVzY3JpcHRpb26IAQESIgoNbW5zdHJfcXJfY29kZRgEIAEoCVILbW5zdHJRckNvZGUSKg'
    'oOY3VycmVudF9oZWFsdGgYBSABKAVIAlINY3VycmVudEhlYWx0aIgBARIiCgptYXhfaGVhbHRo'
    'GAYgASgFSANSCW1heEhlYWx0aIgBARIqCg5jdXJyZW50X2F0dGFjaxgHIAEoBUgEUg1jdXJyZW'
    '50QXR0YWNriAEBEiIKCm1heF9hdHRhY2sYCCABKAVIBVIJbWF4QXR0YWNriAEBEiwKD2N1cnJl'
    'bnRfZGVmZW5zZRgJIAEoBUgGUg5jdXJyZW50RGVmZW5zZYgBARIkCgttYXhfZGVmZW5zZRgKIA'
    'EoBUgHUgptYXhEZWZlbnNliAEBEigKDWN1cnJlbnRfc3BlZWQYCyABKAVICFIMY3VycmVudFNw'
    'ZWVkiAEBEiAKCW1heF9zcGVlZBgMIAEoBUgJUghtYXhTcGVlZIgBARI2ChRjdXJyZW50X2ludG'
    'VsbGlnZW5jZRgNIAEoBUgKUhNjdXJyZW50SW50ZWxsaWdlbmNliAEBEi4KEG1heF9pbnRlbGxp'
    'Z2VuY2UYDiABKAVIC1IPbWF4SW50ZWxsaWdlbmNliAEBEigKDWN1cnJlbnRfbWFnaWMYDyABKA'
    'VIDFIMY3VycmVudE1hZ2ljiAEBEiAKCW1heF9tYWdpYxgQIAEoBUgNUghtYXhNYWdpY4gBAUIN'
    'CgtfbW5zdHJfbmFtZUIUChJfbW5zdHJfZGVzY3JpcHRpb25CEQoPX2N1cnJlbnRfaGVhbHRoQg'
    '0KC19tYXhfaGVhbHRoQhEKD19jdXJyZW50X2F0dGFja0INCgtfbWF4X2F0dGFja0ISChBfY3Vy'
    'cmVudF9kZWZlbnNlQg4KDF9tYXhfZGVmZW5zZUIQCg5fY3VycmVudF9zcGVlZEIMCgpfbWF4X3'
    'NwZWVkQhcKFV9jdXJyZW50X2ludGVsbGlnZW5jZUITChFfbWF4X2ludGVsbGlnZW5jZUIQCg5f'
    'Y3VycmVudF9tYWdpY0IMCgpfbWF4X21hZ2lj');

@$core.Deprecated('Use createMnstrResponseDescriptor instead')
const CreateMnstrResponse$json = {
  '1': 'CreateMnstrResponse',
  '2': [
    {
      '1': 'mnstr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstr'
    },
  ],
};

/// Descriptor for `CreateMnstrResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMnstrResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVNbnN0clJlc3BvbnNlEiQKBW1uc3RyGAEgASgLMg4ubW5zdHJ2Mi5NbnN0clIFbW'
    '5zdHI=');

@$core.Deprecated('Use createMnstrBatchRequestDescriptor instead')
const CreateMnstrBatchRequest$json = {
  '1': 'CreateMnstrBatchRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'mnstrs',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BatchMnstrInput',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `CreateMnstrBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMnstrBatchRequestDescriptor =
    $convert.base64Decode(
        'ChdDcmVhdGVNbnN0ckJhdGNoUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SMAoGbW5zdH'
        'JzGAIgASgLMhgubW5zdHJ2Mi5CYXRjaE1uc3RySW5wdXRSBm1uc3Rycw==');

@$core.Deprecated('Use createMnstrBatchResponseDescriptor instead')
const CreateMnstrBatchResponse$json = {
  '1': 'CreateMnstrBatchResponse',
  '2': [
    {
      '1': 'mnstrs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `CreateMnstrBatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMnstrBatchResponseDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVNbnN0ckJhdGNoUmVzcG9uc2USJgoGbW5zdHJzGAEgAygLMg4ubW5zdHJ2Mi5Nbn'
        'N0clIGbW5zdHJz');

@$core.Deprecated('Use updateMnstrRequestDescriptor instead')
const UpdateMnstrRequest$json = {
  '1': 'UpdateMnstrRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'mnstr_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'mnstrName',
      '17': true
    },
    {
      '1': 'mnstr_description',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'mnstrDescription',
      '17': true
    },
    {
      '1': 'current_health',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'currentHealth',
      '17': true
    },
    {
      '1': 'max_health',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 3,
      '10': 'maxHealth',
      '17': true
    },
    {
      '1': 'current_attack',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'currentAttack',
      '17': true
    },
    {
      '1': 'max_attack',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 5,
      '10': 'maxAttack',
      '17': true
    },
    {
      '1': 'current_defense',
      '3': 10,
      '4': 1,
      '5': 5,
      '9': 6,
      '10': 'currentDefense',
      '17': true
    },
    {
      '1': 'max_defense',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 7,
      '10': 'maxDefense',
      '17': true
    },
    {
      '1': 'current_speed',
      '3': 12,
      '4': 1,
      '5': 5,
      '9': 8,
      '10': 'currentSpeed',
      '17': true
    },
    {
      '1': 'max_speed',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 9,
      '10': 'maxSpeed',
      '17': true
    },
    {
      '1': 'current_intelligence',
      '3': 14,
      '4': 1,
      '5': 5,
      '9': 10,
      '10': 'currentIntelligence',
      '17': true
    },
    {
      '1': 'max_intelligence',
      '3': 15,
      '4': 1,
      '5': 5,
      '9': 11,
      '10': 'maxIntelligence',
      '17': true
    },
    {
      '1': 'current_magic',
      '3': 16,
      '4': 1,
      '5': 5,
      '9': 12,
      '10': 'currentMagic',
      '17': true
    },
    {
      '1': 'max_magic',
      '3': 17,
      '4': 1,
      '5': 5,
      '9': 13,
      '10': 'maxMagic',
      '17': true
    },
  ],
  '8': [
    {'1': '_mnstr_name'},
    {'1': '_mnstr_description'},
    {'1': '_current_health'},
    {'1': '_max_health'},
    {'1': '_current_attack'},
    {'1': '_max_attack'},
    {'1': '_current_defense'},
    {'1': '_max_defense'},
    {'1': '_current_speed'},
    {'1': '_max_speed'},
    {'1': '_current_intelligence'},
    {'1': '_max_intelligence'},
    {'1': '_current_magic'},
    {'1': '_max_magic'},
  ],
};

/// Descriptor for `UpdateMnstrRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMnstrRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVNbnN0clJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEg4KAmlkGAIgASgJUg'
    'JpZBIiCgptbnN0cl9uYW1lGAMgASgJSABSCW1uc3RyTmFtZYgBARIwChFtbnN0cl9kZXNjcmlw'
    'dGlvbhgEIAEoCUgBUhBtbnN0ckRlc2NyaXB0aW9uiAEBEioKDmN1cnJlbnRfaGVhbHRoGAYgAS'
    'gFSAJSDWN1cnJlbnRIZWFsdGiIAQESIgoKbWF4X2hlYWx0aBgHIAEoBUgDUgltYXhIZWFsdGiI'
    'AQESKgoOY3VycmVudF9hdHRhY2sYCCABKAVIBFINY3VycmVudEF0dGFja4gBARIiCgptYXhfYX'
    'R0YWNrGAkgASgFSAVSCW1heEF0dGFja4gBARIsCg9jdXJyZW50X2RlZmVuc2UYCiABKAVIBlIO'
    'Y3VycmVudERlZmVuc2WIAQESJAoLbWF4X2RlZmVuc2UYCyABKAVIB1IKbWF4RGVmZW5zZYgBAR'
    'IoCg1jdXJyZW50X3NwZWVkGAwgASgFSAhSDGN1cnJlbnRTcGVlZIgBARIgCgltYXhfc3BlZWQY'
    'DSABKAVICVIIbWF4U3BlZWSIAQESNgoUY3VycmVudF9pbnRlbGxpZ2VuY2UYDiABKAVIClITY3'
    'VycmVudEludGVsbGlnZW5jZYgBARIuChBtYXhfaW50ZWxsaWdlbmNlGA8gASgFSAtSD21heElu'
    'dGVsbGlnZW5jZYgBARIoCg1jdXJyZW50X21hZ2ljGBAgASgFSAxSDGN1cnJlbnRNYWdpY4gBAR'
    'IgCgltYXhfbWFnaWMYESABKAVIDVIIbWF4TWFnaWOIAQFCDQoLX21uc3RyX25hbWVCFAoSX21u'
    'c3RyX2Rlc2NyaXB0aW9uQhEKD19jdXJyZW50X2hlYWx0aEINCgtfbWF4X2hlYWx0aEIRCg9fY3'
    'VycmVudF9hdHRhY2tCDQoLX21heF9hdHRhY2tCEgoQX2N1cnJlbnRfZGVmZW5zZUIOCgxfbWF4'
    'X2RlZmVuc2VCEAoOX2N1cnJlbnRfc3BlZWRCDAoKX21heF9zcGVlZEIXChVfY3VycmVudF9pbn'
    'RlbGxpZ2VuY2VCEwoRX21heF9pbnRlbGxpZ2VuY2VCEAoOX2N1cnJlbnRfbWFnaWNCDAoKX21h'
    'eF9tYWdpYw==');

@$core.Deprecated('Use updateMnstrResponseDescriptor instead')
const UpdateMnstrResponse$json = {
  '1': 'UpdateMnstrResponse',
  '2': [
    {
      '1': 'mnstr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstr'
    },
  ],
};

/// Descriptor for `UpdateMnstrResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMnstrResponseDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVNbnN0clJlc3BvbnNlEiQKBW1uc3RyGAEgASgLMg4ubW5zdHJ2Mi5NbnN0clIFbW'
    '5zdHI=');

@$core.Deprecated('Use updateMnstrBatchRequestDescriptor instead')
const UpdateMnstrBatchRequest$json = {
  '1': 'UpdateMnstrBatchRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'mnstrs',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BatchMnstrInput',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `UpdateMnstrBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMnstrBatchRequestDescriptor =
    $convert.base64Decode(
        'ChdVcGRhdGVNbnN0ckJhdGNoUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SMAoGbW5zdH'
        'JzGAIgASgLMhgubW5zdHJ2Mi5CYXRjaE1uc3RySW5wdXRSBm1uc3Rycw==');

@$core.Deprecated('Use updateMnstrBatchResponseDescriptor instead')
const UpdateMnstrBatchResponse$json = {
  '1': 'UpdateMnstrBatchResponse',
  '2': [
    {
      '1': 'mnstrs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'mnstrs'
    },
  ],
};

/// Descriptor for `UpdateMnstrBatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMnstrBatchResponseDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVNbnN0ckJhdGNoUmVzcG9uc2USJgoGbW5zdHJzGAEgAygLMg4ubW5zdHJ2Mi5Nbn'
        'N0clIGbW5zdHJz');
