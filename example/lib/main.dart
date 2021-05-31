import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WifiInfoWrapper _wifiObject;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject = wifiObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Center();
    if (_wifiObject != null) {
      String ipAddress = _wifiObject.ipAddress;
      String routerIp = _wifiObject.routerIp;
      String dns1 = _wifiObject.dns1;
      String dns2 = _wifiObject.dns2;
      String bssId = _wifiObject.bssId;
      String ssid = _wifiObject.ssid;
      String macAddress = _wifiObject.macAddress;
      String linkSpeed = _wifiObject.linkSpeed.toString();
      String signalStrength = _wifiObject.signalStrength.toString();
      String frequency = _wifiObject.frequency.toString();
      String networkId = _wifiObject.networkId.toString();
      String connectionType = _wifiObject.connectionType;
      String interfaceName = _wifiObject.interfaceName;
      String isHiddenSSid = _wifiObject.isHiddenSSid.toString();
      widget = Column(
        children: [
          Text('ipAddress:' + ipAddress),
          Text('routerIp:' + routerIp),
          Text('dns1:' + dns1),
          Text('dns2:' + dns2),
          Text('bssId:' + bssId),
          Text('ssid:' + ssid),
          Text('macAddress:' + macAddress),
          Text('linkSpeed:' + linkSpeed),
          Text('signalStrength:' + signalStrength),
          Text('frequency:' + frequency),
          Text('networkId:' + networkId),
          Text('connectionType:' + connectionType),
          Text('interfaceName:' + interfaceName),
          Text('isHiddenSSid:' + isHiddenSSid),
        ]
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: widget,
      ),
    );
  }
}
