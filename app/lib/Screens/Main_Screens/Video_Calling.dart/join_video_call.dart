import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

final userid = Random().nextInt(9999);

class JoinVideoCall extends StatelessWidget {
  const JoinVideoCall({super.key, required this.callid});
  final String callid;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1397913354,
      appSign:
          'f1b5181f323fe7eb1822faf654318cdd28e2b8e0cfdc62cdb8e060a8f0b9c6b5',
      userID: userid.toString(),
      userName: 'Username $userid',
      callID: callid,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
