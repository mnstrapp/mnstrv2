// This is a generated file - do not edit.
//
// Generated from battles.proto.

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

@$core.Deprecated('Use battleStatusStateDescriptor instead')
const BattleStatusState$json = {
  '1': 'BattleStatusState',
  '2': [
    {'1': 'BATTLE_STATUS_STATE_UNSPECIFIED', '2': 0},
    {'1': 'BATTLE_STATUS_STATE_IN_QUEUE', '2': 1},
    {'1': 'BATTLE_STATUS_STATE_IN_BATTLE', '2': 2},
    {'1': 'BATTLE_STATUS_STATE_WATCHING', '2': 3},
  ],
};

/// Descriptor for `BattleStatusState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List battleStatusStateDescriptor = $convert.base64Decode(
    'ChFCYXR0bGVTdGF0dXNTdGF0ZRIjCh9CQVRUTEVfU1RBVFVTX1NUQVRFX1VOU1BFQ0lGSUVEEA'
    'ASIAocQkFUVExFX1NUQVRVU19TVEFURV9JTl9RVUVVRRABEiEKHUJBVFRMRV9TVEFUVVNfU1RB'
    'VEVfSU5fQkFUVExFEAISIAocQkFUVExFX1NUQVRVU19TVEFURV9XQVRDSElORxAD');

@$core.Deprecated('Use battlePhaseDescriptor instead')
const BattlePhase$json = {
  '1': 'BattlePhase',
  '2': [
    {'1': 'BATTLE_PHASE_UNSPECIFIED', '2': 0},
    {'1': 'BATTLE_PHASE_CHOOSING_MNSTRS', '2': 1},
    {'1': 'BATTLE_PHASE_IN_PROGRESS', '2': 2},
    {'1': 'BATTLE_PHASE_ENDED', '2': 3},
  ],
};

/// Descriptor for `BattlePhase`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List battlePhaseDescriptor = $convert.base64Decode(
    'CgtCYXR0bGVQaGFzZRIcChhCQVRUTEVfUEhBU0VfVU5TUEVDSUZJRUQQABIgChxCQVRUTEVfUE'
    'hBU0VfQ0hPT1NJTkdfTU5TVFJTEAESHAoYQkFUVExFX1BIQVNFX0lOX1BST0dSRVNTEAISFgoS'
    'QkFUVExFX1BIQVNFX0VOREVEEAM=');

@$core.Deprecated('Use battleTurnActionDescriptor instead')
const BattleTurnAction$json = {
  '1': 'BattleTurnAction',
  '2': [
    {'1': 'BATTLE_TURN_ACTION_UNSPECIFIED', '2': 0},
    {'1': 'BATTLE_TURN_ACTION_ATTACK', '2': 1},
    {'1': 'BATTLE_TURN_ACTION_DEFEND', '2': 2},
    {'1': 'BATTLE_TURN_ACTION_MAGIC', '2': 3},
  ],
};

/// Descriptor for `BattleTurnAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List battleTurnActionDescriptor = $convert.base64Decode(
    'ChBCYXR0bGVUdXJuQWN0aW9uEiIKHkJBVFRMRV9UVVJOX0FDVElPTl9VTlNQRUNJRklFRBAAEh'
    '0KGUJBVFRMRV9UVVJOX0FDVElPTl9BVFRBQ0sQARIdChlCQVRUTEVfVFVSTl9BQ1RJT05fREVG'
    'RU5EEAISHAoYQkFUVExFX1RVUk5fQUNUSU9OX01BR0lDEAM=');

@$core.Deprecated('Use battlePlayerDescriptor instead')
const BattlePlayer$json = {
  '1': 'BattlePlayer',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
  ],
};

/// Descriptor for `BattlePlayer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battlePlayerDescriptor = $convert.base64Decode(
    'CgxCYXR0bGVQbGF5ZXISFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGRpc3BsYXlfbmFtZR'
    'gCIAEoCVILZGlzcGxheU5hbWU=');

@$core.Deprecated('Use battleStatusDescriptor instead')
const BattleStatus$json = {
  '1': 'BattleStatus',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'opponent_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'opponentId',
      '17': true
    },
    {
      '1': 'opponent_name',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'opponentName',
      '17': true
    },
    {
      '1': 'battle_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'battleId',
      '17': true
    },
    {
      '1': 'status',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.mnstrv2.BattleStatusState',
      '10': 'status'
    },
  ],
  '8': [
    {'1': '_opponent_id'},
    {'1': '_opponent_name'},
    {'1': '_battle_id'},
  ],
};

/// Descriptor for `BattleStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battleStatusDescriptor = $convert.base64Decode(
    'CgxCYXR0bGVTdGF0dXMSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiQKC29wcG9uZW50X2lkGAQgASgJ'
    'SABSCm9wcG9uZW50SWSIAQESKAoNb3Bwb25lbnRfbmFtZRgFIAEoCUgBUgxvcHBvbmVudE5hbW'
    'WIAQESIAoJYmF0dGxlX2lkGAYgASgJSAJSCGJhdHRsZUlkiAEBEjIKBnN0YXR1cxgHIAEoDjIa'
    'Lm1uc3RydjIuQmF0dGxlU3RhdHVzU3RhdGVSBnN0YXR1c0IOCgxfb3Bwb25lbnRfaWRCEAoOX2'
    '9wcG9uZW50X25hbWVCDAoKX2JhdHRsZV9pZA==');

@$core.Deprecated('Use battleStateDescriptor instead')
const BattleState$json = {
  '1': 'BattleState',
  '2': [
    {'1': 'battle_id', '3': 1, '4': 1, '5': 9, '10': 'battleId'},
    {
      '1': 'phase',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.mnstrv2.BattlePhase',
      '10': 'phase'
    },
    {
      '1': 'challenger',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'challenger'
    },
    {
      '1': 'opponent',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'opponent'
    },
    {
      '1': 'challenger_mnstr',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'challengerMnstr'
    },
    {
      '1': 'opponent_mnstr',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'opponentMnstr'
    },
    {
      '1': 'challenger_mnstrs',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'challengerMnstrs'
    },
    {
      '1': 'opponent_mnstrs',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.Mnstr',
      '10': 'opponentMnstrs'
    },
    {'1': 'turn_user_id', '3': 9, '4': 1, '5': 9, '10': 'turnUserId'},
  ],
};

/// Descriptor for `BattleState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battleStateDescriptor = $convert.base64Decode(
    'CgtCYXR0bGVTdGF0ZRIbCgliYXR0bGVfaWQYASABKAlSCGJhdHRsZUlkEioKBXBoYXNlGAIgAS'
    'gOMhQubW5zdHJ2Mi5CYXR0bGVQaGFzZVIFcGhhc2USNQoKY2hhbGxlbmdlchgDIAEoCzIVLm1u'
    'c3RydjIuQmF0dGxlUGxheWVyUgpjaGFsbGVuZ2VyEjEKCG9wcG9uZW50GAQgASgLMhUubW5zdH'
    'J2Mi5CYXR0bGVQbGF5ZXJSCG9wcG9uZW50EjkKEGNoYWxsZW5nZXJfbW5zdHIYBSABKAsyDi5t'
    'bnN0cnYyLk1uc3RyUg9jaGFsbGVuZ2VyTW5zdHISNQoOb3Bwb25lbnRfbW5zdHIYBiABKAsyDi'
    '5tbnN0cnYyLk1uc3RyUg1vcHBvbmVudE1uc3RyEjsKEWNoYWxsZW5nZXJfbW5zdHJzGAcgAygL'
    'Mg4ubW5zdHJ2Mi5NbnN0clIQY2hhbGxlbmdlck1uc3RycxI3Cg9vcHBvbmVudF9tbnN0cnMYCC'
    'ADKAsyDi5tbnN0cnYyLk1uc3RyUg5vcHBvbmVudE1uc3RycxIgCgx0dXJuX3VzZXJfaWQYCSAB'
    'KAlSCnR1cm5Vc2VySWQ=');

@$core.Deprecated('Use turnResultDescriptor instead')
const TurnResult$json = {
  '1': 'TurnResult',
  '2': [
    {'1': 'actor_user_id', '3': 1, '4': 1, '5': 9, '10': 'actorUserId'},
    {'1': 'actor_mnstr_id', '3': 2, '4': 1, '5': 9, '10': 'actorMnstrId'},
    {
      '1': 'action',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.mnstrv2.BattleTurnAction',
      '10': 'action'
    },
    {'1': 'hit', '3': 4, '4': 1, '5': 8, '10': 'hit'},
    {'1': 'missed', '3': 5, '4': 1, '5': 8, '10': 'missed'},
    {'1': 'damage', '3': 6, '4': 1, '5': 5, '10': 'damage'},
    {'1': 'defense', '3': 7, '4': 1, '5': 5, '10': 'defense'},
  ],
};

/// Descriptor for `TurnResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List turnResultDescriptor = $convert.base64Decode(
    'CgpUdXJuUmVzdWx0EiIKDWFjdG9yX3VzZXJfaWQYASABKAlSC2FjdG9yVXNlcklkEiQKDmFjdG'
    '9yX21uc3RyX2lkGAIgASgJUgxhY3Rvck1uc3RySWQSMQoGYWN0aW9uGAMgASgOMhkubW5zdHJ2'
    'Mi5CYXR0bGVUdXJuQWN0aW9uUgZhY3Rpb24SEAoDaGl0GAQgASgIUgNoaXQSFgoGbWlzc2VkGA'
    'UgASgIUgZtaXNzZWQSFgoGZGFtYWdlGAYgASgFUgZkYW1hZ2USGAoHZGVmZW5zZRgHIAEoBVIH'
    'ZGVmZW5zZQ==');

@$core.Deprecated('Use battleRewardsDescriptor instead')
const BattleRewards$json = {
  '1': 'BattleRewards',
  '2': [
    {'1': 'xp_awarded', '3': 1, '4': 1, '5': 5, '10': 'xpAwarded'},
    {'1': 'coins_awarded', '3': 2, '4': 1, '5': 5, '10': 'coinsAwarded'},
  ],
};

/// Descriptor for `BattleRewards`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battleRewardsDescriptor = $convert.base64Decode(
    'Cg1CYXR0bGVSZXdhcmRzEh0KCnhwX2F3YXJkZWQYASABKAVSCXhwQXdhcmRlZBIjCg1jb2luc1'
    '9hd2FyZGVkGAIgASgFUgxjb2luc0F3YXJkZWQ=');

@$core.Deprecated('Use gameEndedDescriptor instead')
const GameEnded$json = {
  '1': 'GameEnded',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
    {'1': 'winner_id', '3': 2, '4': 1, '5': 9, '10': 'winnerId'},
    {'1': 'loser_id', '3': 3, '4': 1, '5': 9, '10': 'loserId'},
    {
      '1': 'winner_rewards',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleRewards',
      '10': 'winnerRewards'
    },
    {
      '1': 'loser_rewards',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleRewards',
      '10': 'loserRewards'
    },
    {'1': 'escaped', '3': 6, '4': 1, '5': 8, '10': 'escaped'},
  ],
};

/// Descriptor for `GameEnded`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameEndedDescriptor = $convert.base64Decode(
    'CglHYW1lRW5kZWQSKgoFc3RhdGUYASABKAsyFC5tbnN0cnYyLkJhdHRsZVN0YXRlUgVzdGF0ZR'
    'IbCgl3aW5uZXJfaWQYAiABKAlSCHdpbm5lcklkEhkKCGxvc2VyX2lkGAMgASgJUgdsb3Nlcklk'
    'Ej0KDndpbm5lcl9yZXdhcmRzGAQgASgLMhYubW5zdHJ2Mi5CYXR0bGVSZXdhcmRzUg13aW5uZX'
    'JSZXdhcmRzEjsKDWxvc2VyX3Jld2FyZHMYBSABKAsyFi5tbnN0cnYyLkJhdHRsZVJld2FyZHNS'
    'DGxvc2VyUmV3YXJkcxIYCgdlc2NhcGVkGAYgASgIUgdlc2NhcGVk');

@$core.Deprecated('Use playerJoinedDescriptor instead')
const PlayerJoined$json = {
  '1': 'PlayerJoined',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `PlayerJoined`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerJoinedDescriptor = $convert.base64Decode(
    'CgxQbGF5ZXJKb2luZWQSLQoGc3RhdHVzGAEgASgLMhUubW5zdHJ2Mi5CYXR0bGVTdGF0dXNSBn'
    'N0YXR1cw==');

@$core.Deprecated('Use playerLeftDescriptor instead')
const PlayerLeft$json = {
  '1': 'PlayerLeft',
  '2': [
    {
      '1': 'player',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'player'
    },
  ],
};

/// Descriptor for `PlayerLeft`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerLeftDescriptor = $convert.base64Decode(
    'CgpQbGF5ZXJMZWZ0Ei0KBnBsYXllchgBIAEoCzIVLm1uc3RydjIuQmF0dGxlUGxheWVyUgZwbG'
    'F5ZXI=');

@$core.Deprecated('Use playerStatusChangedDescriptor instead')
const PlayerStatusChanged$json = {
  '1': 'PlayerStatusChanged',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `PlayerStatusChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerStatusChangedDescriptor = $convert.base64Decode(
    'ChNQbGF5ZXJTdGF0dXNDaGFuZ2VkEi0KBnN0YXR1cxgBIAEoCzIVLm1uc3RydjIuQmF0dGxlU3'
    'RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use challengeReceivedDescriptor instead')
const ChallengeReceived$json = {
  '1': 'ChallengeReceived',
  '2': [
    {'1': 'challenge_id', '3': 1, '4': 1, '5': 9, '10': 'challengeId'},
    {
      '1': 'challenger',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'challenger'
    },
    {
      '1': 'opponent',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'opponent'
    },
  ],
};

/// Descriptor for `ChallengeReceived`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeReceivedDescriptor = $convert.base64Decode(
    'ChFDaGFsbGVuZ2VSZWNlaXZlZBIhCgxjaGFsbGVuZ2VfaWQYASABKAlSC2NoYWxsZW5nZUlkEj'
    'UKCmNoYWxsZW5nZXIYAiABKAsyFS5tbnN0cnYyLkJhdHRsZVBsYXllclIKY2hhbGxlbmdlchIx'
    'CghvcHBvbmVudBgDIAEoCzIVLm1uc3RydjIuQmF0dGxlUGxheWVyUghvcHBvbmVudA==');

@$core.Deprecated('Use challengeCancelledDescriptor instead')
const ChallengeCancelled$json = {
  '1': 'ChallengeCancelled',
  '2': [
    {'1': 'challenge_id', '3': 1, '4': 1, '5': 9, '10': 'challengeId'},
    {
      '1': 'challenger',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'challenger'
    },
  ],
};

/// Descriptor for `ChallengeCancelled`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeCancelledDescriptor = $convert.base64Decode(
    'ChJDaGFsbGVuZ2VDYW5jZWxsZWQSIQoMY2hhbGxlbmdlX2lkGAEgASgJUgtjaGFsbGVuZ2VJZB'
    'I1CgpjaGFsbGVuZ2VyGAIgASgLMhUubW5zdHJ2Mi5CYXR0bGVQbGF5ZXJSCmNoYWxsZW5nZXI=');

@$core.Deprecated('Use challengeRejectedDescriptor instead')
const ChallengeRejected$json = {
  '1': 'ChallengeRejected',
  '2': [
    {'1': 'challenge_id', '3': 1, '4': 1, '5': 9, '10': 'challengeId'},
    {
      '1': 'opponent',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'opponent'
    },
  ],
};

/// Descriptor for `ChallengeRejected`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeRejectedDescriptor = $convert.base64Decode(
    'ChFDaGFsbGVuZ2VSZWplY3RlZBIhCgxjaGFsbGVuZ2VfaWQYASABKAlSC2NoYWxsZW5nZUlkEj'
    'EKCG9wcG9uZW50GAIgASgLMhUubW5zdHJ2Mi5CYXR0bGVQbGF5ZXJSCG9wcG9uZW50');

@$core.Deprecated('Use challengeAcceptedDescriptor instead')
const ChallengeAccepted$json = {
  '1': 'ChallengeAccepted',
  '2': [
    {'1': 'challenge_id', '3': 1, '4': 1, '5': 9, '10': 'challengeId'},
    {
      '1': 'opponent',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattlePlayer',
      '10': 'opponent'
    },
    {'1': 'battle_id', '3': 3, '4': 1, '5': 9, '10': 'battleId'},
  ],
};

/// Descriptor for `ChallengeAccepted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeAcceptedDescriptor = $convert.base64Decode(
    'ChFDaGFsbGVuZ2VBY2NlcHRlZBIhCgxjaGFsbGVuZ2VfaWQYASABKAlSC2NoYWxsZW5nZUlkEj'
    'EKCG9wcG9uZW50GAIgASgLMhUubW5zdHJ2Mi5CYXR0bGVQbGF5ZXJSCG9wcG9uZW50EhsKCWJh'
    'dHRsZV9pZBgDIAEoCVIIYmF0dGxlSWQ=');

@$core.Deprecated('Use gameStartedDescriptor instead')
const GameStarted$json = {
  '1': 'GameStarted',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `GameStarted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStartedDescriptor = $convert.base64Decode(
    'CgtHYW1lU3RhcnRlZBIqCgVzdGF0ZRgBIAEoCzIULm1uc3RydjIuQmF0dGxlU3RhdGVSBXN0YX'
    'Rl');

@$core.Deprecated('Use mnstrChosenDescriptor instead')
const MnstrChosen$json = {
  '1': 'MnstrChosen',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `MnstrChosen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mnstrChosenDescriptor = $convert.base64Decode(
    'CgtNbnN0ckNob3NlbhIqCgVzdGF0ZRgBIAEoCzIULm1uc3RydjIuQmF0dGxlU3RhdGVSBXN0YX'
    'RlEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use turnTakenDescriptor instead')
const TurnTaken$json = {
  '1': 'TurnTaken',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.TurnResult',
      '10': 'result'
    },
    {
      '1': 'state',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `TurnTaken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List turnTakenDescriptor = $convert.base64Decode(
    'CglUdXJuVGFrZW4SKwoGcmVzdWx0GAEgASgLMhMubW5zdHJ2Mi5UdXJuUmVzdWx0UgZyZXN1bH'
    'QSKgoFc3RhdGUYAiABKAsyFC5tbnN0cnYyLkJhdHRsZVN0YXRlUgVzdGF0ZQ==');

@$core.Deprecated('Use rejoinedDescriptor instead')
const Rejoined$json = {
  '1': 'Rejoined',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Rejoined`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejoinedDescriptor = $convert.base64Decode(
    'CghSZWpvaW5lZBIqCgVzdGF0ZRgBIAEoCzIULm1uc3RydjIuQmF0dGxlU3RhdGVSBXN0YXRlEh'
    'cKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use battleErrorDescriptor instead')
const BattleError$json = {
  '1': 'BattleError',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'battle_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'battleId',
      '17': true
    },
  ],
  '8': [
    {'1': '_battle_id'},
  ],
};

/// Descriptor for `BattleError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battleErrorDescriptor = $convert.base64Decode(
    'CgtCYXR0bGVFcnJvchIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEiAKCWJhdHRsZV9pZBgCIA'
    'EoCUgAUghiYXR0bGVJZIgBAUIMCgpfYmF0dGxlX2lk');

@$core.Deprecated('Use battleEventDescriptor instead')
const BattleEvent$json = {
  '1': 'BattleEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'player_joined',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.PlayerJoined',
      '9': 0,
      '10': 'playerJoined'
    },
    {
      '1': 'player_left',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.PlayerLeft',
      '9': 0,
      '10': 'playerLeft'
    },
    {
      '1': 'player_status_changed',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.PlayerStatusChanged',
      '9': 0,
      '10': 'playerStatusChanged'
    },
    {
      '1': 'challenge_received',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.ChallengeReceived',
      '9': 0,
      '10': 'challengeReceived'
    },
    {
      '1': 'challenge_cancelled',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.ChallengeCancelled',
      '9': 0,
      '10': 'challengeCancelled'
    },
    {
      '1': 'challenge_rejected',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.ChallengeRejected',
      '9': 0,
      '10': 'challengeRejected'
    },
    {
      '1': 'challenge_accepted',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.ChallengeAccepted',
      '9': 0,
      '10': 'challengeAccepted'
    },
    {
      '1': 'game_started',
      '3': 30,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.GameStarted',
      '9': 0,
      '10': 'gameStarted'
    },
    {
      '1': 'mnstr_chosen',
      '3': 31,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.MnstrChosen',
      '9': 0,
      '10': 'mnstrChosen'
    },
    {
      '1': 'turn_taken',
      '3': 32,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.TurnTaken',
      '9': 0,
      '10': 'turnTaken'
    },
    {
      '1': 'game_ended',
      '3': 33,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.GameEnded',
      '9': 0,
      '10': 'gameEnded'
    },
    {
      '1': 'rejoined',
      '3': 34,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.Rejoined',
      '9': 0,
      '10': 'rejoined'
    },
    {
      '1': 'error',
      '3': 90,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleError',
      '9': 0,
      '10': 'error'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `BattleEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List battleEventDescriptor = $convert.base64Decode(
    'CgtCYXR0bGVFdmVudBIOCgJpZBgBIAEoCVICaWQSPAoNcGxheWVyX2pvaW5lZBgKIAEoCzIVLm'
    '1uc3RydjIuUGxheWVySm9pbmVkSABSDHBsYXllckpvaW5lZBI2CgtwbGF5ZXJfbGVmdBgLIAEo'
    'CzITLm1uc3RydjIuUGxheWVyTGVmdEgAUgpwbGF5ZXJMZWZ0ElIKFXBsYXllcl9zdGF0dXNfY2'
    'hhbmdlZBgMIAEoCzIcLm1uc3RydjIuUGxheWVyU3RhdHVzQ2hhbmdlZEgAUhNwbGF5ZXJTdGF0'
    'dXNDaGFuZ2VkEksKEmNoYWxsZW5nZV9yZWNlaXZlZBgUIAEoCzIaLm1uc3RydjIuQ2hhbGxlbm'
    'dlUmVjZWl2ZWRIAFIRY2hhbGxlbmdlUmVjZWl2ZWQSTgoTY2hhbGxlbmdlX2NhbmNlbGxlZBgV'
    'IAEoCzIbLm1uc3RydjIuQ2hhbGxlbmdlQ2FuY2VsbGVkSABSEmNoYWxsZW5nZUNhbmNlbGxlZB'
    'JLChJjaGFsbGVuZ2VfcmVqZWN0ZWQYFiABKAsyGi5tbnN0cnYyLkNoYWxsZW5nZVJlamVjdGVk'
    'SABSEWNoYWxsZW5nZVJlamVjdGVkEksKEmNoYWxsZW5nZV9hY2NlcHRlZBgXIAEoCzIaLm1uc3'
    'RydjIuQ2hhbGxlbmdlQWNjZXB0ZWRIAFIRY2hhbGxlbmdlQWNjZXB0ZWQSOQoMZ2FtZV9zdGFy'
    'dGVkGB4gASgLMhQubW5zdHJ2Mi5HYW1lU3RhcnRlZEgAUgtnYW1lU3RhcnRlZBI5CgxtbnN0cl'
    '9jaG9zZW4YHyABKAsyFC5tbnN0cnYyLk1uc3RyQ2hvc2VuSABSC21uc3RyQ2hvc2VuEjMKCnR1'
    'cm5fdGFrZW4YICABKAsyEi5tbnN0cnYyLlR1cm5UYWtlbkgAUgl0dXJuVGFrZW4SMwoKZ2FtZV'
    '9lbmRlZBghIAEoCzISLm1uc3RydjIuR2FtZUVuZGVkSABSCWdhbWVFbmRlZBIvCghyZWpvaW5l'
    'ZBgiIAEoCzIRLm1uc3RydjIuUmVqb2luZWRIAFIIcmVqb2luZWQSLAoFZXJyb3IYWiABKAsyFC'
    '5tbnN0cnYyLkJhdHRsZUVycm9ySABSBWVycm9yQgkKB3BheWxvYWQ=');

@$core.Deprecated('Use joinBattleQueueRequestDescriptor instead')
const JoinBattleQueueRequest$json = {
  '1': 'JoinBattleQueueRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `JoinBattleQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinBattleQueueRequestDescriptor =
    $convert.base64Decode(
        'ChZKb2luQmF0dGxlUXVldWVSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use leaveBattleQueueRequestDescriptor instead')
const LeaveBattleQueueRequest$json = {
  '1': 'LeaveBattleQueueRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LeaveBattleQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveBattleQueueRequestDescriptor =
    $convert.base64Decode(
        'ChdMZWF2ZUJhdHRsZVF1ZXVlUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use leaveBattleQueueResponseDescriptor instead')
const LeaveBattleQueueResponse$json = {
  '1': 'LeaveBattleQueueResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `LeaveBattleQueueResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveBattleQueueResponseDescriptor =
    $convert.base64Decode(
        'ChhMZWF2ZUJhdHRsZVF1ZXVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use listBattlePlayersRequestDescriptor instead')
const ListBattlePlayersRequest$json = {
  '1': 'ListBattlePlayersRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ListBattlePlayersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBattlePlayersRequestDescriptor =
    $convert.base64Decode(
        'ChhMaXN0QmF0dGxlUGxheWVyc1JlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2Vu');

@$core.Deprecated('Use listBattlePlayersResponseDescriptor instead')
const ListBattlePlayersResponse$json = {
  '1': 'ListBattlePlayersResponse',
  '2': [
    {
      '1': 'statuses',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mnstrv2.BattleStatus',
      '10': 'statuses'
    },
  ],
};

/// Descriptor for `ListBattlePlayersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBattlePlayersResponseDescriptor =
    $convert.base64Decode(
        'ChlMaXN0QmF0dGxlUGxheWVyc1Jlc3BvbnNlEjEKCHN0YXR1c2VzGAEgAygLMhUubW5zdHJ2Mi'
        '5CYXR0bGVTdGF0dXNSCHN0YXR1c2Vz');

@$core.Deprecated('Use challengeRequestDescriptor instead')
const ChallengeRequest$json = {
  '1': 'ChallengeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'opponent_id', '3': 2, '4': 1, '5': 9, '10': 'opponentId'},
  ],
};

/// Descriptor for `ChallengeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeRequestDescriptor = $convert.base64Decode(
    'ChBDaGFsbGVuZ2VSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIfCgtvcHBvbmVudF9pZB'
    'gCIAEoCVIKb3Bwb25lbnRJZA==');

@$core.Deprecated('Use challengeResponseDescriptor instead')
const ChallengeResponse$json = {
  '1': 'ChallengeResponse',
  '2': [
    {'1': 'challenge_id', '3': 1, '4': 1, '5': 9, '10': 'challengeId'},
  ],
};

/// Descriptor for `ChallengeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeResponseDescriptor = $convert.base64Decode(
    'ChFDaGFsbGVuZ2VSZXNwb25zZRIhCgxjaGFsbGVuZ2VfaWQYASABKAlSC2NoYWxsZW5nZUlk');

@$core.Deprecated('Use cancelChallengeRequestDescriptor instead')
const CancelChallengeRequest$json = {
  '1': 'CancelChallengeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'challenge_id', '3': 2, '4': 1, '5': 9, '10': 'challengeId'},
    {'1': 'opponent_id', '3': 3, '4': 1, '5': 9, '10': 'opponentId'},
  ],
};

/// Descriptor for `CancelChallengeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelChallengeRequestDescriptor = $convert.base64Decode(
    'ChZDYW5jZWxDaGFsbGVuZ2VSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIhCgxjaGFsbG'
    'VuZ2VfaWQYAiABKAlSC2NoYWxsZW5nZUlkEh8KC29wcG9uZW50X2lkGAMgASgJUgpvcHBvbmVu'
    'dElk');

@$core.Deprecated('Use cancelChallengeResponseDescriptor instead')
const CancelChallengeResponse$json = {
  '1': 'CancelChallengeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CancelChallengeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelChallengeResponseDescriptor =
    $convert.base64Decode(
        'ChdDYW5jZWxDaGFsbGVuZ2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use acceptChallengeRequestDescriptor instead')
const AcceptChallengeRequest$json = {
  '1': 'AcceptChallengeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'challenge_id', '3': 2, '4': 1, '5': 9, '10': 'challengeId'},
    {'1': 'challenger_id', '3': 3, '4': 1, '5': 9, '10': 'challengerId'},
  ],
};

/// Descriptor for `AcceptChallengeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptChallengeRequestDescriptor = $convert.base64Decode(
    'ChZBY2NlcHRDaGFsbGVuZ2VSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIhCgxjaGFsbG'
    'VuZ2VfaWQYAiABKAlSC2NoYWxsZW5nZUlkEiMKDWNoYWxsZW5nZXJfaWQYAyABKAlSDGNoYWxs'
    'ZW5nZXJJZA==');

@$core.Deprecated('Use acceptChallengeResponseDescriptor instead')
const AcceptChallengeResponse$json = {
  '1': 'AcceptChallengeResponse',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `AcceptChallengeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptChallengeResponseDescriptor =
    $convert.base64Decode(
        'ChdBY2NlcHRDaGFsbGVuZ2VSZXNwb25zZRIqCgVzdGF0ZRgBIAEoCzIULm1uc3RydjIuQmF0dG'
        'xlU3RhdGVSBXN0YXRl');

@$core.Deprecated('Use rejectChallengeRequestDescriptor instead')
const RejectChallengeRequest$json = {
  '1': 'RejectChallengeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'challenge_id', '3': 2, '4': 1, '5': 9, '10': 'challengeId'},
    {'1': 'challenger_id', '3': 3, '4': 1, '5': 9, '10': 'challengerId'},
  ],
};

/// Descriptor for `RejectChallengeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejectChallengeRequestDescriptor = $convert.base64Decode(
    'ChZSZWplY3RDaGFsbGVuZ2VSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIhCgxjaGFsbG'
    'VuZ2VfaWQYAiABKAlSC2NoYWxsZW5nZUlkEiMKDWNoYWxsZW5nZXJfaWQYAyABKAlSDGNoYWxs'
    'ZW5nZXJJZA==');

@$core.Deprecated('Use rejectChallengeResponseDescriptor instead')
const RejectChallengeResponse$json = {
  '1': 'RejectChallengeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `RejectChallengeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejectChallengeResponseDescriptor =
    $convert.base64Decode(
        'ChdSZWplY3RDaGFsbGVuZ2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use chooseMnstrRequestDescriptor instead')
const ChooseMnstrRequest$json = {
  '1': 'ChooseMnstrRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'battle_id', '3': 2, '4': 1, '5': 9, '10': 'battleId'},
    {'1': 'mnstr_id', '3': 3, '4': 1, '5': 9, '10': 'mnstrId'},
  ],
};

/// Descriptor for `ChooseMnstrRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chooseMnstrRequestDescriptor = $convert.base64Decode(
    'ChJDaG9vc2VNbnN0clJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEhsKCWJhdHRsZV9pZB'
    'gCIAEoCVIIYmF0dGxlSWQSGQoIbW5zdHJfaWQYAyABKAlSB21uc3RySWQ=');

@$core.Deprecated('Use chooseMnstrResponseDescriptor instead')
const ChooseMnstrResponse$json = {
  '1': 'ChooseMnstrResponse',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `ChooseMnstrResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chooseMnstrResponseDescriptor = $convert.base64Decode(
    'ChNDaG9vc2VNbnN0clJlc3BvbnNlEioKBXN0YXRlGAEgASgLMhQubW5zdHJ2Mi5CYXR0bGVTdG'
    'F0ZVIFc3RhdGU=');

@$core.Deprecated('Use turnRequestDescriptor instead')
const TurnRequest$json = {
  '1': 'TurnRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'battle_id', '3': 2, '4': 1, '5': 9, '10': 'battleId'},
  ],
};

/// Descriptor for `TurnRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List turnRequestDescriptor = $convert.base64Decode(
    'CgtUdXJuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SGwoJYmF0dGxlX2lkGAIgASgJUg'
    'hiYXR0bGVJZA==');

@$core.Deprecated('Use turnResponseDescriptor instead')
const TurnResponse$json = {
  '1': 'TurnResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.TurnResult',
      '10': 'result'
    },
    {
      '1': 'state',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
    {
      '1': 'game_ended',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.GameEnded',
      '10': 'gameEnded'
    },
  ],
};

/// Descriptor for `TurnResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List turnResponseDescriptor = $convert.base64Decode(
    'CgxUdXJuUmVzcG9uc2USKwoGcmVzdWx0GAEgASgLMhMubW5zdHJ2Mi5UdXJuUmVzdWx0UgZyZX'
    'N1bHQSKgoFc3RhdGUYAiABKAsyFC5tbnN0cnYyLkJhdHRsZVN0YXRlUgVzdGF0ZRIxCgpnYW1l'
    'X2VuZGVkGAMgASgLMhIubW5zdHJ2Mi5HYW1lRW5kZWRSCWdhbWVFbmRlZA==');

@$core.Deprecated('Use escapeRequestDescriptor instead')
const EscapeRequest$json = {
  '1': 'EscapeRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'battle_id', '3': 2, '4': 1, '5': 9, '10': 'battleId'},
  ],
};

/// Descriptor for `EscapeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List escapeRequestDescriptor = $convert.base64Decode(
    'Cg1Fc2NhcGVSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIbCgliYXR0bGVfaWQYAiABKA'
    'lSCGJhdHRsZUlk');

@$core.Deprecated('Use escapeResponseDescriptor instead')
const EscapeResponse$json = {
  '1': 'EscapeResponse',
  '2': [
    {
      '1': 'game_ended',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.GameEnded',
      '10': 'gameEnded'
    },
  ],
};

/// Descriptor for `EscapeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List escapeResponseDescriptor = $convert.base64Decode(
    'Cg5Fc2NhcGVSZXNwb25zZRIxCgpnYW1lX2VuZGVkGAEgASgLMhIubW5zdHJ2Mi5HYW1lRW5kZW'
    'RSCWdhbWVFbmRlZA==');

@$core.Deprecated('Use rejoinRequestDescriptor instead')
const RejoinRequest$json = {
  '1': 'RejoinRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'battle_id', '3': 2, '4': 1, '5': 9, '10': 'battleId'},
  ],
};

/// Descriptor for `RejoinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejoinRequestDescriptor = $convert.base64Decode(
    'Cg1SZWpvaW5SZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIbCgliYXR0bGVfaWQYAiABKA'
    'lSCGJhdHRsZUlk');

@$core.Deprecated('Use rejoinResponseDescriptor instead')
const RejoinResponse$json = {
  '1': 'RejoinResponse',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.mnstrv2.BattleState',
      '10': 'state'
    },
  ],
};

/// Descriptor for `RejoinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejoinResponseDescriptor = $convert.base64Decode(
    'Cg5SZWpvaW5SZXNwb25zZRIqCgVzdGF0ZRgBIAEoCzIULm1uc3RydjIuQmF0dGxlU3RhdGVSBX'
    'N0YXRl');
