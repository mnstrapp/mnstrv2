import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../providers/auth.dart';
import '../models/monster.dart';
import '../manage/list.dart';
import 'local_storage.dart';

import '../proto/mnstr.pb.dart' as proto_mnstr;
import '../proto/mnstr.pbgrpc.dart' as proto_mnstr_grpc;

final manageProvider = NotifierProvider<ManageNotifier, List<Monster>>(
  () => ManageNotifier(),
);

class ManageNotifier extends Notifier<List<Monster>> {
  @override
  List<Monster> build() {
    return [];
  }

  Future<String?> getMonsters() async {
    final auth = ref.read(authProvider);

    if (auth == null) {
      final monsters = await LocalStorage.getMnstrs();
      state = monsters;
      return null;
    }

    final order = ref.read(manageOrderProvider);

    final orderBy = switch (order.orderBy) {
      ManageOrderBy.createdAt =>
        proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_CREATED_AT,
      ManageOrderBy.updatedAt =>
        proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_UPDATED_AT,
      ManageOrderBy.name => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_NAME,
      ManageOrderBy.level => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_LEVEL,
      ManageOrderBy.experience =>
        proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_EXPERIENCE,
      ManageOrderBy.health => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_HEALTH,
      ManageOrderBy.attack => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_ATTACK,
      ManageOrderBy.defense => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_DEFENSE,
      ManageOrderBy.intelligence =>
        proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_INTELLIGENCE,
      ManageOrderBy.speed => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_SPEED,
      ManageOrderBy.magic => proto_mnstr.MnstrOrderBy.MNSTR_ORDER_BY_MAGIC,
    };

    final orderDirection = switch (order.orderDirection) {
      ManageOrderDirection.asc =>
        proto_mnstr.MnstrOrderDirection.MNSTR_ORDER_DIRECTION_ASC,
      ManageOrderDirection.desc =>
        proto_mnstr.MnstrOrderDirection.MNSTR_ORDER_DIRECTION_DESC,
    };

    final request = proto_mnstr.ListMnstrsRequest(
      token: auth.token,
      orderBy: orderBy,
      orderDirection: orderDirection,
    );

    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    final monsters = <Monster>[];

    try {
      final response = await proto_mnstr_grpc.MnstrServiceClient(
        channel,
      ).list(request);
      if (response.mnstrs.isNotEmpty) {
        for (var mnstr in response.mnstrs) {
          monsters.add(Monster.fromProto(mnstr));
        }
      }
    } catch (e, stackTrace) {
      debugPrint('getMonsters error: $e, $stackTrace');
      return "There was an error getting the monsters";
    }

    state = monsters;
    return null;
  }
}

final manageGetByQRProvider = NotifierProvider<ManageGetByQRNotifier, Monster?>(
  () => ManageGetByQRNotifier(),
);

class ManageGetByQRNotifier extends Notifier<Monster?> {
  @override
  Monster? build() {
    return null;
  }

  Future<String?> get(String qrCode) async {
    final auth = ref.read(authProvider);

    if (auth == null) {
      final mnstr = await LocalStorage.getMnstrByQrCode(qrCode);
      if (mnstr == null) {
        return "Monster not found";
      }
      state = mnstr;
      return null;
    }
    try {
      final channel = ClientChannel(
        endpoints.apiHost,
        port: endpoints.apiPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final response =
          await proto_mnstr_grpc.MnstrServiceClient(
            channel,
          ).getByQrCode(
            proto_mnstr.GetMnstrByQrCodeRequest(
              token: auth.token,
              mnstrQrCode: qrCode,
            ),
          );
      if (response.hasMnstr()) {
        state = Monster.fromProto(response.mnstr);
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('getByQR error: $e, $stackTrace');
      return "There was an error getting the monster by QR code";
    }
    return "Monster not found";
  }
}

final manageEditProvider = NotifierProvider<ManageEditNotifier, Monster?>(
  () => ManageEditNotifier(),
);

class ManageEditNotifier extends Notifier<Monster?> {
  @override
  Monster? build() {
    return null;
  }

  void set(Monster monster) {
    state = monster;
  }

  Future<String?> editMonster(Monster monster) async {
    final auth = ref.read(authProvider);

    if (auth == null) {
      final error = await LocalStorage.addMnstr(monster);
      if (error != null) {
        debugPrint('[editMonster] Error: $error, ${StackTrace.current}');
        return error;
      }
      state = monster;
      return null;
    }

    try {
      final channel = ClientChannel(
        endpoints.apiHost,
        port: endpoints.apiPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final request = proto_mnstr.UpdateMnstrRequest(
        token: auth.token,
        id: monster.id,
        mnstrName: monster.mnstrName,
        mnstrDescription: monster.mnstrDescription,
        currentHealth: monster.currentHealth,
        maxHealth: monster.maxHealth,
        currentAttack: monster.currentAttack,
        maxAttack: monster.maxAttack,
        currentDefense: monster.currentDefense,
        maxDefense: monster.maxDefense,
        currentIntelligence: monster.currentIntelligence,
        maxIntelligence: monster.maxIntelligence,
        currentSpeed: monster.currentSpeed,
        maxSpeed: monster.maxSpeed,
        currentMagic: monster.currentMagic,
        maxMagic: monster.maxMagic,
      );
      final response = await proto_mnstr_grpc.MnstrServiceClient(
        channel,
      ).update(request);
      if (response.hasMnstr()) {
        state = Monster.fromProto(response.mnstr);
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('editMonster error: $e, $stackTrace');
      return "There was an error editing the monster";
    }
    return "There was an error editing the monster";
  }
}

class ManageOrder {
  final ManageOrderBy orderBy;
  final ManageOrderDirection orderDirection;

  const ManageOrder({
    this.orderBy = ManageOrderBy.updatedAt,
    this.orderDirection = ManageOrderDirection.desc,
  });
}

final manageOrderProvider = NotifierProvider<ManageOrderNotifier, ManageOrder>(
  () => ManageOrderNotifier(),
);

class ManageOrderNotifier extends Notifier<ManageOrder> {
  @override
  ManageOrder build() {
    return ManageOrder();
  }

  void set({
    ManageOrderBy orderBy = ManageOrderBy.updatedAt,
    ManageOrderDirection orderDirection = ManageOrderDirection.desc,
  }) {
    state = ManageOrder(orderBy: orderBy, orderDirection: orderDirection);
    setManageOrder(orderBy, orderDirection);
  }

  Future<void> init() async {
    final (orderBy, orderDirection) = await getManageOrderBy();
    set(orderBy: orderBy, orderDirection: orderDirection);
  }
}

enum ManageOrderByKey { manageOrderBy }

enum ManageOrderDirectionKey { manageOrderDirection }

Future<void> setManageOrder(
  ManageOrderBy by,
  ManageOrderDirection direction,
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(ManageOrderByKey.manageOrderBy.name, by.name);
  prefs.setString(
    ManageOrderDirectionKey.manageOrderDirection.name,
    direction.name,
  );
}

Future<(ManageOrderBy, ManageOrderDirection)> getManageOrderBy() async {
  final prefs = await SharedPreferences.getInstance();
  return (
    ManageOrderBy.values.byName(
      prefs.getString(ManageOrderByKey.manageOrderBy.name) ??
          ManageOrderBy.updatedAt.name,
    ),
    ManageOrderDirection.values.byName(
      prefs.getString(ManageOrderDirectionKey.manageOrderDirection.name) ??
          ManageOrderDirection.asc.name,
    ),
  );
}
