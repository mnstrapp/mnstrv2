// This is a generated file - do not edit.
//
// Generated from battles.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'battles.pb.dart' as $0;

export 'battles.pb.dart';

@$pb.GrpcServiceName('mnstrv2.BattleService')
class BattleServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  BattleServiceClient(super.channel, {super.options, super.interceptors});

  /// Lobby
  $grpc.ResponseStream<$0.BattleEvent> join(
    $0.JoinBattleQueueRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$join, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.LeaveBattleQueueResponse> leave(
    $0.LeaveBattleQueueRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$leave, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListBattlePlayersResponse> listPlayers(
    $0.ListBattlePlayersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listPlayers, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChallengeResponse> challenge(
    $0.ChallengeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$challenge, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelChallengeResponse> cancelChallenge(
    $0.CancelChallengeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$0.AcceptChallengeResponse> acceptChallenge(
    $0.AcceptChallengeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$acceptChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$0.RejectChallengeResponse> rejectChallenge(
    $0.RejectChallengeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$rejectChallenge, request, options: options);
  }

  /// Battle
  $grpc.ResponseFuture<$0.ChooseMnstrResponse> chooseMnstr(
    $0.ChooseMnstrRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$chooseMnstr, request, options: options);
  }

  $grpc.ResponseFuture<$0.TurnResponse> attack(
    $0.TurnRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$attack, request, options: options);
  }

  $grpc.ResponseFuture<$0.TurnResponse> defend(
    $0.TurnRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$defend, request, options: options);
  }

  $grpc.ResponseFuture<$0.TurnResponse> magic(
    $0.TurnRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$magic, request, options: options);
  }

  $grpc.ResponseFuture<$0.EscapeResponse> escape(
    $0.EscapeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$escape, request, options: options);
  }

  $grpc.ResponseFuture<$0.RejoinResponse> rejoin(
    $0.RejoinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$rejoin, request, options: options);
  }

  // method descriptors

  static final _$join =
      $grpc.ClientMethod<$0.JoinBattleQueueRequest, $0.BattleEvent>(
          '/mnstrv2.BattleService/Join',
          ($0.JoinBattleQueueRequest value) => value.writeToBuffer(),
          $0.BattleEvent.fromBuffer);
  static final _$leave = $grpc.ClientMethod<$0.LeaveBattleQueueRequest,
          $0.LeaveBattleQueueResponse>(
      '/mnstrv2.BattleService/Leave',
      ($0.LeaveBattleQueueRequest value) => value.writeToBuffer(),
      $0.LeaveBattleQueueResponse.fromBuffer);
  static final _$listPlayers = $grpc.ClientMethod<$0.ListBattlePlayersRequest,
          $0.ListBattlePlayersResponse>(
      '/mnstrv2.BattleService/ListPlayers',
      ($0.ListBattlePlayersRequest value) => value.writeToBuffer(),
      $0.ListBattlePlayersResponse.fromBuffer);
  static final _$challenge =
      $grpc.ClientMethod<$0.ChallengeRequest, $0.ChallengeResponse>(
          '/mnstrv2.BattleService/Challenge',
          ($0.ChallengeRequest value) => value.writeToBuffer(),
          $0.ChallengeResponse.fromBuffer);
  static final _$cancelChallenge =
      $grpc.ClientMethod<$0.CancelChallengeRequest, $0.CancelChallengeResponse>(
          '/mnstrv2.BattleService/CancelChallenge',
          ($0.CancelChallengeRequest value) => value.writeToBuffer(),
          $0.CancelChallengeResponse.fromBuffer);
  static final _$acceptChallenge =
      $grpc.ClientMethod<$0.AcceptChallengeRequest, $0.AcceptChallengeResponse>(
          '/mnstrv2.BattleService/AcceptChallenge',
          ($0.AcceptChallengeRequest value) => value.writeToBuffer(),
          $0.AcceptChallengeResponse.fromBuffer);
  static final _$rejectChallenge =
      $grpc.ClientMethod<$0.RejectChallengeRequest, $0.RejectChallengeResponse>(
          '/mnstrv2.BattleService/RejectChallenge',
          ($0.RejectChallengeRequest value) => value.writeToBuffer(),
          $0.RejectChallengeResponse.fromBuffer);
  static final _$chooseMnstr =
      $grpc.ClientMethod<$0.ChooseMnstrRequest, $0.ChooseMnstrResponse>(
          '/mnstrv2.BattleService/ChooseMnstr',
          ($0.ChooseMnstrRequest value) => value.writeToBuffer(),
          $0.ChooseMnstrResponse.fromBuffer);
  static final _$attack = $grpc.ClientMethod<$0.TurnRequest, $0.TurnResponse>(
      '/mnstrv2.BattleService/Attack',
      ($0.TurnRequest value) => value.writeToBuffer(),
      $0.TurnResponse.fromBuffer);
  static final _$defend = $grpc.ClientMethod<$0.TurnRequest, $0.TurnResponse>(
      '/mnstrv2.BattleService/Defend',
      ($0.TurnRequest value) => value.writeToBuffer(),
      $0.TurnResponse.fromBuffer);
  static final _$magic = $grpc.ClientMethod<$0.TurnRequest, $0.TurnResponse>(
      '/mnstrv2.BattleService/Magic',
      ($0.TurnRequest value) => value.writeToBuffer(),
      $0.TurnResponse.fromBuffer);
  static final _$escape =
      $grpc.ClientMethod<$0.EscapeRequest, $0.EscapeResponse>(
          '/mnstrv2.BattleService/Escape',
          ($0.EscapeRequest value) => value.writeToBuffer(),
          $0.EscapeResponse.fromBuffer);
  static final _$rejoin =
      $grpc.ClientMethod<$0.RejoinRequest, $0.RejoinResponse>(
          '/mnstrv2.BattleService/Rejoin',
          ($0.RejoinRequest value) => value.writeToBuffer(),
          $0.RejoinResponse.fromBuffer);
}

@$pb.GrpcServiceName('mnstrv2.BattleService')
abstract class BattleServiceBase extends $grpc.Service {
  $core.String get $name => 'mnstrv2.BattleService';

  BattleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JoinBattleQueueRequest, $0.BattleEvent>(
        'Join',
        join_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.JoinBattleQueueRequest.fromBuffer(value),
        ($0.BattleEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveBattleQueueRequest,
            $0.LeaveBattleQueueResponse>(
        'Leave',
        leave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LeaveBattleQueueRequest.fromBuffer(value),
        ($0.LeaveBattleQueueResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListBattlePlayersRequest,
            $0.ListBattlePlayersResponse>(
        'ListPlayers',
        listPlayers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListBattlePlayersRequest.fromBuffer(value),
        ($0.ListBattlePlayersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChallengeRequest, $0.ChallengeResponse>(
        'Challenge',
        challenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChallengeRequest.fromBuffer(value),
        ($0.ChallengeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelChallengeRequest,
            $0.CancelChallengeResponse>(
        'CancelChallenge',
        cancelChallenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelChallengeRequest.fromBuffer(value),
        ($0.CancelChallengeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcceptChallengeRequest,
            $0.AcceptChallengeResponse>(
        'AcceptChallenge',
        acceptChallenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AcceptChallengeRequest.fromBuffer(value),
        ($0.AcceptChallengeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RejectChallengeRequest,
            $0.RejectChallengeResponse>(
        'RejectChallenge',
        rejectChallenge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RejectChallengeRequest.fromBuffer(value),
        ($0.RejectChallengeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ChooseMnstrRequest, $0.ChooseMnstrResponse>(
            'ChooseMnstr',
            chooseMnstr_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ChooseMnstrRequest.fromBuffer(value),
            ($0.ChooseMnstrResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TurnRequest, $0.TurnResponse>(
        'Attack',
        attack_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TurnRequest.fromBuffer(value),
        ($0.TurnResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TurnRequest, $0.TurnResponse>(
        'Defend',
        defend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TurnRequest.fromBuffer(value),
        ($0.TurnResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TurnRequest, $0.TurnResponse>(
        'Magic',
        magic_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TurnRequest.fromBuffer(value),
        ($0.TurnResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EscapeRequest, $0.EscapeResponse>(
        'Escape',
        escape_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EscapeRequest.fromBuffer(value),
        ($0.EscapeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RejoinRequest, $0.RejoinResponse>(
        'Rejoin',
        rejoin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RejoinRequest.fromBuffer(value),
        ($0.RejoinResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.BattleEvent> join_Pre($grpc.ServiceCall $call,
      $async.Future<$0.JoinBattleQueueRequest> $request) async* {
    yield* join($call, await $request);
  }

  $async.Stream<$0.BattleEvent> join(
      $grpc.ServiceCall call, $0.JoinBattleQueueRequest request);

  $async.Future<$0.LeaveBattleQueueResponse> leave_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LeaveBattleQueueRequest> $request) async {
    return leave($call, await $request);
  }

  $async.Future<$0.LeaveBattleQueueResponse> leave(
      $grpc.ServiceCall call, $0.LeaveBattleQueueRequest request);

  $async.Future<$0.ListBattlePlayersResponse> listPlayers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListBattlePlayersRequest> $request) async {
    return listPlayers($call, await $request);
  }

  $async.Future<$0.ListBattlePlayersResponse> listPlayers(
      $grpc.ServiceCall call, $0.ListBattlePlayersRequest request);

  $async.Future<$0.ChallengeResponse> challenge_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ChallengeRequest> $request) async {
    return challenge($call, await $request);
  }

  $async.Future<$0.ChallengeResponse> challenge(
      $grpc.ServiceCall call, $0.ChallengeRequest request);

  $async.Future<$0.CancelChallengeResponse> cancelChallenge_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelChallengeRequest> $request) async {
    return cancelChallenge($call, await $request);
  }

  $async.Future<$0.CancelChallengeResponse> cancelChallenge(
      $grpc.ServiceCall call, $0.CancelChallengeRequest request);

  $async.Future<$0.AcceptChallengeResponse> acceptChallenge_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AcceptChallengeRequest> $request) async {
    return acceptChallenge($call, await $request);
  }

  $async.Future<$0.AcceptChallengeResponse> acceptChallenge(
      $grpc.ServiceCall call, $0.AcceptChallengeRequest request);

  $async.Future<$0.RejectChallengeResponse> rejectChallenge_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RejectChallengeRequest> $request) async {
    return rejectChallenge($call, await $request);
  }

  $async.Future<$0.RejectChallengeResponse> rejectChallenge(
      $grpc.ServiceCall call, $0.RejectChallengeRequest request);

  $async.Future<$0.ChooseMnstrResponse> chooseMnstr_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ChooseMnstrRequest> $request) async {
    return chooseMnstr($call, await $request);
  }

  $async.Future<$0.ChooseMnstrResponse> chooseMnstr(
      $grpc.ServiceCall call, $0.ChooseMnstrRequest request);

  $async.Future<$0.TurnResponse> attack_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TurnRequest> $request) async {
    return attack($call, await $request);
  }

  $async.Future<$0.TurnResponse> attack(
      $grpc.ServiceCall call, $0.TurnRequest request);

  $async.Future<$0.TurnResponse> defend_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TurnRequest> $request) async {
    return defend($call, await $request);
  }

  $async.Future<$0.TurnResponse> defend(
      $grpc.ServiceCall call, $0.TurnRequest request);

  $async.Future<$0.TurnResponse> magic_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TurnRequest> $request) async {
    return magic($call, await $request);
  }

  $async.Future<$0.TurnResponse> magic(
      $grpc.ServiceCall call, $0.TurnRequest request);

  $async.Future<$0.EscapeResponse> escape_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EscapeRequest> $request) async {
    return escape($call, await $request);
  }

  $async.Future<$0.EscapeResponse> escape(
      $grpc.ServiceCall call, $0.EscapeRequest request);

  $async.Future<$0.RejoinResponse> rejoin_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RejoinRequest> $request) async {
    return rejoin($call, await $request);
  }

  $async.Future<$0.RejoinResponse> rejoin(
      $grpc.ServiceCall call, $0.RejoinRequest request);
}
