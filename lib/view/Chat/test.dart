import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPusher extends StatefulWidget {
  const TestPusher({Key? key}) : super(key: key);

  @override
  State<TestPusher> createState() => _TestPusherState();
}

class _TestPusherState extends State<TestPusher> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String _log = 'output:\n';
  final _apiKey = TextEditingController();
  final _cluster = TextEditingController();
  final _channelName = TextEditingController();
  final _eventName = TextEditingController();
  final _channelFormKey = GlobalKey<FormState>();
  final _eventFormKey = GlobalKey<FormState>();
  final _listViewController = ScrollController();
  final _data = TextEditingController();

  void log(String text) {
    print("LOG: $text");
    setState(() {
      _log += "$text\n";
      Timer(
          const Duration(milliseconds: 100),
          () => _listViewController
              .jumpTo(_listViewController.position.maxScrollExtent));
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onConnectPressed() async {
    if (!_channelFormKey.currentState!.validate()) {
      return;
    }
    // Remove keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("apiKey", _apiKey.text);
    // prefs.setString("cluster", _cluster.text);
    // prefs.setString("channelName", _channelName.text);

    try {
      await pusher.init(
        apiKey: "0eb37b85a7487830f814",
        cluster: "ap2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );

      await pusher.subscribe(channelName: "chat_2_3");
      await pusher.connect();
      // final myChannel = await pusher.subscribe(
      //     channelName: _channelName.text,
      //     onEvent: onEvent
      // );
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    print("Event vAlue");
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "foo:bar",
      "channel_data": '{"user_id": 1}',
      "shared_secret": "foobar"
    };
  }

  void onTriggerEventPressed() async {
    var eventFormValidated = _eventFormKey.currentState!.validate();

    if (!eventFormValidated) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("eventName", _eventName.text);
    prefs.setString("data", _data.text);
    pusher.trigger(PusherEvent(
        channelName: "chat_2_10",
        eventName: _eventName.text,
        data: _data.text));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _apiKey.text = "0eb37b85a7487830f814";
      _cluster.text = "ap2";
      _channelName.text = "chat_11_3";
      _eventName.text = 'client-event';
      _data.text = 'test';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(pusher.connectionState == 'DISCONNECTED'
              ? 'Pusher Channels Example'
              : "chat_2_10"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              controller: _listViewController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                if (pusher.connectionState != 'CONNECTED')
                  Form(
                      key: _channelFormKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          controller: _apiKey,
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'Please enter your API key.'
                                : null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'API Key'),
                        ),
                        TextFormField(
                          controller: _cluster,
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'Please enter your cluster.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Cluster',
                          ),
                        ),
                        TextFormField(
                          controller: _channelName,
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'Please enter your channel name.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Channel',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await pusher.init(
                              apiKey: "0eb37b85a7487830f814",
                              cluster: "ap2",
                              onConnectionStateChange: onConnectionStateChange,
                              onError: onError,
                              onSubscriptionSucceeded: onSubscriptionSucceeded,
                              onEvent: onEvent,
                              onSubscriptionError: onSubscriptionError,
                              onDecryptionFailure: onDecryptionFailure,
                              onMemberAdded: onMemberAdded,
                              onMemberRemoved: onMemberRemoved,
                              onSubscriptionCount: onSubscriptionCount,
                              // authEndpoint: "<Your Authendpoint Url>",
                              // onAuthorizer: onAuthorizer
                            );

                            await pusher.subscribe(channelName: "chat_2_10");
                            await pusher.connect();
                          },
                          child: const Text('Connect'),
                        )
                      ]))
                else
                  Form(
                    key: _eventFormKey,
                    child: Column(children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              pusher.channels["chat_2_10"]?.members.length,
                          itemBuilder: (context, index) {
                            final member = pusher
                                .channels["chat_2_10"]!.members.values
                                .elementAt(index);

                            return ListTile(
                                title: Text(member.userInfo.toString()),
                                subtitle: Text(member.userId));
                          }),
                      TextFormField(
                        controller: _eventName,
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'Please enter your event name.'
                              : null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Event',
                        ),
                      ),
                      TextFormField(
                        controller: _data,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onTriggerEventPressed,
                        child: const Text('Trigger Event'),
                      ),
                    ]),
                  ),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: Text(_log)),
              ]),
        ),
      ),
    );
  }
}
