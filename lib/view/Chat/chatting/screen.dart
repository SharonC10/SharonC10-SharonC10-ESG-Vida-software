import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/chat.dart';
import 'package:ESGVida/view/Chat/chatting/messages.dart';
import 'package:ESGVida/view/Chat/chatting/utils.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/gallery/model.dart';
import 'package:ESGVida/screens/gallery/screen.dart';
import 'package:ESGVida/view/Chat/widgets/local_image_view.dart';
import 'package:ESGVida/view/Chat/pdf_screen.dart';
import 'package:ESGVida/view/Chat/video_play_screen.dart';
import 'package:ESGVida/widgets/future_widget.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  String UserName;
  String UserId;

  ChatPage({super.key, required this.UserId, required this.UserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  // PusherChannelsFlutter pusher2 = PusherChannelsFlutter.getInstance();
  List<types.Message> _messages = [];
  final _user = types.User(
    id: GlobalInMemoryData.I.userId.toString(),
  );
  bool emojiShowing = false;
  bool startVoiceRecording = false;
  final _scrollController = ScrollController();
  TextEditingController chatController = TextEditingController();

  final chatProvider = Get.find<ChatProvider>();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  final focusNode = FocusNode();

  onEmojiSelected(Emoji emoji) {
    setState(() {
      chatController
        ..text += emoji.emoji
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: chatController.text.length));
    });
  }

  onBackspacePressed() {
    setState(() {
      chatController
        ..text = chatController.text.characters.skipLast(1).toString()
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: chatController.text.length));
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      elevation: 0,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            children: [
              10.height,
              Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color(0xFF96929D)),
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.width,
                  const Text(
                    "Choose file format",
                    style: CommonStyle.black14Medium,
                  ),
                ],
              ),
              10.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  10.width,
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.8, color: Colors.grey)),
                      //       :
                      //   BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(width: 0.8,color: Colors.transparent)
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.photo,
                            color: Colors.grey,
                            size: 28,
                          ),
                          5.height,
                          Text("Photo",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  ),
                  15.width,
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.8, color: Colors.grey)),
                      //       :
                      //   BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(width: 0.8,color: Colors.transparent)
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.file_copy,
                            color: Colors.grey,
                            size: 28,
                          ),
                          5.height,
                          Text("File",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);

      sendMessage(filePath: result.files.single.path!);
      setState(() {
        chatController.clear();
      });
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        width: image.width.toDouble(),
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
      );

      _addMessage(message);
      sendMessage(filePath: result.path);
      setState(() {
        chatController.clear();
      });
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      // await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  bool isLoadMessage = false;

  void _loadMessages() async {
    setState(() {
      isLoadMessage = true;
    });
    chatProvider.getMessages(receiverId: widget.UserId).then((value) {
      if (value.isFail) {
        setState(() {
          isLoadMessage = false;
        });
        return;
      }
      setState(() {
        _messages = value.data!.reversed.toList();
        isLoadMessage = false;
      });
    });
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

    await pusher.subscribe(
        channelName:
            "chat_${widget.UserId.toString()}_${GlobalInMemoryData.I.userId}");
    await pusher.connect();

    // Api.commonPostApi(body: body,apiEndPoint: ApiUrl.fetchMessage).then((value) {
    //   List res = value["data"];
    //   Iterable dd = res.reversed;
    //   final messages = (res as List).reversed
    //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
    //       .toList();
    //
    //   setState(() {
    //     _messages = messages;
    //     isLoadMessage = false;
    //   });
    // });
    // await pusher2.init(
    //   apiKey:"0eb37b85a7487830f814",
    //   cluster: "ap2",
    //   onConnectionStateChange: onConnectionStateChange2,
    //   onError: onError2,
    //   onSubscriptionSucceeded: onSubscriptionSucceeded2,
    //   onEvent: onEvent2,
    //   onSubscriptionError: onSubscriptionError2,
    //   onDecryptionFailure: onDecryptionFailure2,
    //   onMemberAdded: onMemberAdded2,
    //   onMemberRemoved: onMemberRemoved2,
    //   onSubscriptionCount: onSubscriptionCount2,
    //   // authEndpoint: "<Your Authendpoint Url>",
    //   // onAuthorizer: onAuthorizer
    // );
    //
    // await pusher2.subscribe(channelName:"chat_${DataManager.getInstance().getUserId()}_${widget.UserId.toString()}");
    // await pusher2.connect();
    // final response = await rootBundle.loadString('assets/messages.json');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          backgroundColor: const Color(0xFF0094EE),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              )),
          title: Text(
            ' ${widget.UserName.toString()}',
            style: CommonStyle.white22Medium,
          ),
          titleSpacing: 0,
        ),
        body: WillPopScope(
          onWillPop: () {
            if (emojiShowing) {
              emojiShowing = false;
              setState(() {});
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: isLoadMessage
              ? Center(
                  child: loadingWidget(),
                )
              : Chat(
                  messages: _messages,
                  onAttachmentPressed: _handleAttachmentPressed,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  showUserAvatars: false,
                  showUserNames: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  hideBackgroundOnEmojiMessages: false,
                  timeFormat: DateFormat("hh:mm a"),

                  fileMessageBuilder: (message, {required messageWidth}) {
                    double fileSize = message.size / 1024;
                    double filesizeMb = fileSize / 1024;
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            String extension =
                                message.uri.toString().split(".").last;
                            if (message.uri.toString().startsWith("http")) {
                              if (extension.toString().toUpperCase() == "PNG" ||
                                  extension.toString().toUpperCase() == "JPG" ||
                                  extension.toString().toUpperCase() ==
                                      "JPEG") {
                                Get.to(() => GalleryImageViewWrapper(
                                      titleGallery: "Image View",
                                      galleryItems: [
                                        GalleryItemModel(
                                            id: "0",
                                            imageUrl: message.uri.toString())
                                      ],
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      initialIndex: 0,
                                      scrollDirection: Axis.horizontal,
                                    ));
                              } else if (extension.toString().toUpperCase() ==
                                  "MP4") {
                                Get.to(() => VideoPlay(
                                      VideoUrl: message.uri.toString(),
                                      type: "http",
                                    ));
                              } else if (extension.toString().toUpperCase() ==
                                  "PDF") {
                                Get.to(() => PDFViewerPage(
                                      pdfUrl: message.uri.toString(),
                                      name: message.name,
                                      type: "http",
                                    ));
                              } else {
                                showToast("File not supported");
                              }
                            } else {
                              ///Local file

                              if (extension.toString().toUpperCase() == "PNG" ||
                                  extension.toString().toUpperCase() == "JPG" ||
                                  extension.toString().toUpperCase() ==
                                      "JPEG") {
                                Get.to(() => LocalImageView(
                                      url: message.uri.toString(),
                                    ));
                              } else if (extension.toString().toUpperCase() ==
                                  "MP4") {
                                Get.to(() => VideoPlay(
                                      VideoUrl: message.uri.toString(),
                                      type: "file",
                                    ));
                              } else if (extension.toString().toUpperCase() ==
                                  "PDF") {
                                Get.to(() => PDFViewerPage(
                                      pdfUrl: message.uri.toString(),
                                      name: message.name,
                                      type: "local",
                                    ));
                              } else {
                                showToast("File not supported");
                              }
                            }
                            print(message.uri.toString().startsWith("http"));
                          },
                          child: FileMessageWidget(
                            message: message,
                            isReceiver:
                                message.author.id.toString() == widget.UserId,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 10,
                          child: Text(
                            message.createdAt!.toFriendlyDatetimeStr(),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  textMessageBuilder: (message,
                      {required messageWidth, required showName}) {
                    return TextMessageWidget(
                        message: message, receiverId: widget.UserId);
                  },
                  imageMessageBuilder: (message, {required messageWidth}) {
                    return _buildImageMessage(message);
                  },

                  // bubbleBuilder: (child, {required message, required nextMessageInGroup}) {
                  //
                  //   return Container(
                  //        padding: EdgeInsets.zero,
                  //       decoration: BoxDecoration(
                  //           color:message.author.id.toString() == DataManager.getInstance().getUserId()? Colors.grey.shade100:Colors.blue.shade50,
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: child);
                  // },

                  customBottomWidget: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          10.width,
                          Flexible(
                            child: TextFormField(
                              controller: chatController,
                              autofocus: false,
                              focusNode: focusNode,
                              onTap: () {
                                emojiShowing = false;
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none),
                                fillColor: CommonColor.bgColor,
                                hintText:
                                    "${LanguageGlobalVar.ENTER_MESSAGE.tr}...",
                                hintStyle: CommonStyle.grey14Medium,
                              ),
                            ),
                          ),
                          5.width,

                          startVoiceRecording
                              ? const SizedBox()
                              : emojiShowing
                                  ? InkWell(
                                      onTap: () {
                                        focusNode.requestFocus();
                                        emojiShowing = false;
                                        setState(() {});
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(
                                          Icons.keyboard,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EmojiPicker(),));
                                        setState(() {
                                          focusNode.unfocus();
                                          emojiShowing = !emojiShowing;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.emoji_emotions_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      )),
                          startVoiceRecording ? const SizedBox() : 8.width,
                          startVoiceRecording
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    _handleAttachmentPressed();
                                  },
                                  child: const Icon(
                                    Icons.folder_copy_outlined,
                                    color: Colors.black,
                                    size: 24,
                                  )),
                          // 8.width,
                          // chatController.text.isEmpty?
                          // SocialMediaRecorder(
                          //   sendButtonIcon: Center(
                          //     child:Icon(
                          //       Icons.keyboard_voice_sharp,size: 24,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          //   recordIcon: Center(
                          //     child:Icon(
                          //       Icons.keyboard_voice_sharp,size: 24,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          //   sendRequestFunction: (soundFile, _time) {
                          //
                          //     print("createAudioRecording${soundFile}");
                          //   },
                          //   startRecording: () {
                          //
                          //     setState(() {
                          //       startVoiceRecording= true;
                          //     });
                          //     print("pleasecheck");
                          //     // controller.createVideoTextHide.value==false?controller.createVideoTextHide.value=true:controller.createVideoTextHide.value=false;
                          //   },
                          //   stopRecording: (time) {
                          //     print("pleasecheck");
                          //     setState(() {
                          //       startVoiceRecording= false;
                          //     });
                          //     // controller.createVideoTextHide.value==false?controller.createVideoTextHide.value=true:controller.createVideoTextHide.value=false;
                          //   },
                          //   encode: AudioEncoderType.AAC,
                          // ):
                          InkWell(
                              onTap: () {
                                if (chatController.text.isNotEmpty) {
                                  final textMessage = types.TextMessage(
                                    author: _user,
                                    createdAt:
                                        DateTime.now().millisecondsSinceEpoch ~/
                                            1000,
                                    id: const Uuid().v4(),
                                    text: chatController.text,
                                  );
                                  _addMessage(textMessage);
                                  sendMessage(
                                      message: chatController.text.toString());

                                  setState(() {
                                    chatController.clear();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue.shade300,
                                    radius: 16,
                                    child: const Icon(Icons.send,
                                        color: Colors.white, size: 20)),
                              )),
                          10.width,
                        ],
                      ),
                      8.height,
                      // Offstage(
                      //   offstage: !emojiShowing,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top:8.0),
                      //     child: EmojiPicker(
                      //       textEditingController: chatController,
                      //       scrollController: _scrollController,
                      //       config: Config(
                      //         height: 256,
                      //         checkPlatformCompatibility: true,
                      //         emojiViewConfig: EmojiViewConfig(
                      //           // Issue: https://github.com/flutter/flutter/issues/28894
                      //           emojiSizeMax: 28 *
                      //               (foundation.defaultTargetPlatform ==
                      //                   TargetPlatform.iOS
                      //                   ? 1.2
                      //                   : 1.0),
                      //         ),
                      //         swapCategoryAndBottomBar: false,
                      //         skinToneConfig: const SkinToneConfig(),
                      //         categoryViewConfig: const CategoryViewConfig(),
                      //         bottomActionBarConfig: const BottomActionBarConfig(),
                      //         searchViewConfig: const SearchViewConfig(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                          height: 240,
                          child: EmojiPicker(
                            onEmojiSelected: (Category? category, Emoji emoji) {
                              onEmojiSelected(emoji);
                              // chatController.text =   chatController.text +emoji.emoji.toString();
                            },
                            onBackspacePressed: onBackspacePressed,
                            config: Config(
                              columns: 9,
                              emojiSizeMax: 24 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.30
                                      : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,

                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: CommonColor.primaryColor,
                              iconColor: Colors.grey,
                              iconColorSelected: CommonColor.primaryColor,
                              backspaceColor: Colors.black,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              // showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recent',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  user: _user,
                  theme: const DefaultChatTheme(seenIcon: SizedBox()),
                ),
        ),
      );

  Widget _buildImageMessage(types.ImageMessage message) {
    if (message.width != null && message.height != null) {
      return ImageMessageWidget(
        message: message,
      );
    }
    final completer = Completer<Dimensions>();
    CachedNetworkImageProvider(message.uri)
        .resolve(ImageConfiguration.empty)
        .addListener(ImageStreamListener((image, synchronousCall) {
      completer.complete((
        width: image.image.width.toDouble(),
        height: image.image.height.toDouble(),
      ));
    }));
    final size = MediaQuery.sizeOf(context);
    return futureWidget(
        future: completer.future,
        errorOrLoadingWidth: size.width * 0.1,
        errorOrLoadingHeight: size.height * 0.1,
        builder: (data) {
          return ImageMessageWidget(
            message: message.copyWith(width: data.width, height: data.height)
                as types.ImageMessage,
          );
        });
  }

  void sendMessage({String message = "", String? filePath}) {
    Map<String, dynamic> data = {
      "receiver_id": widget.UserId.toString(),
      "message": message,
    };
    if (filePath != null) {
      data["file"] = MultipartFile(filePath,
          filename: filePath.isEmpty ? filePath : filePath.filename());
    }
    chatProvider.sendMessage(formData: FormData(data));
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    var data = jsonDecode(event.data);
    print("Event $data");
    log("onEvent: $event");
    final messages =
        types.Message.fromJson(data["message"] as Map<String, dynamic>);
    print("Event message they want to add => $messages");
    _addMessage(messages);
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

//
// void onConnectionStateChange2(dynamic currentState, dynamic previousState) {
//   log("Connection: $currentState");
// }
//
// void onError2(String message, int? code, dynamic e) {
//   log("onError: $message code: $code exception: $e");
// }
//
// void onEvent2(PusherEvent event) {
//   print("Event vAlue");
//   log("onEvent: $event");
//   var data = jsonDecode(event.data);
//   print(data);
//   // if(data["message"]["description"].toString() == ""){
//   //   final messages = types.Message.fromJson(data["message"] as Map<String, dynamic>);
//   //   _addMessage(messages);
//   // }
//
// }
//
// void onSubscriptionSucceeded2(String channelName, dynamic data) {
//   log("onSubscriptionSucceeded: $channelName data: $data");
//   final me = pusher.getChannel(channelName)?.me;
//   log("Me: $me");
// }
//
// void onSubscriptionError2(String message, dynamic e) {
//   log("onSubscriptionError: $message Exception: $e");
// }
//
// void onDecryptionFailure2(String event, String reason) {
//   log("onDecryptionFailure: $event reason: $reason");
// }
//
// void onMemberAdded2(String channelName, PusherMember member) {
//   log("onMemberAdded: $channelName user: $member");
// }
//
// void onMemberRemoved2(String channelName, PusherMember member) {
//   log("onMemberRemoved: $channelName user: $member");
// }
//
// void onSubscriptionCount2(String channelName, int subscriptionCount) {
//   log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
// }
//
// String formatMilliseconds(int milliseconds) {
//   // Convert milliseconds to seconds
//   int seconds = (milliseconds / 1000).floor();
//
//   // Calculate hours, minutes, and remaining seconds
//   int hours = seconds ~/ 3600;
//   int minutes = (seconds % 3600) ~/ 60;
//
//   // Format hours and minutes with leading zeros if needed
//   String hoursStr = hours.toString().padLeft(2, '0');
//   String minutesStr = minutes.toString().padLeft(2, '0');
//
//   return '$hoursStr:$minutesStr';
// }
}
