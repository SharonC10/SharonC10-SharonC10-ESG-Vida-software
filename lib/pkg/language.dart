import 'package:ESGVida/model/user.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnLanguage().enLanguage,
        'zh_Hant': ChLanguage().chlanguage,
        'ja_JP': JPLanguage().jplanguage,
      };
}

class LanguageGlobalVar {
  static String MODIFY_PURCHASE_AMOUNT = "Modify purchase amount";
  static String SET_TO_DEFAULT_ADDRESS = "Set to default address";
  static String ENTER_ADDRESS = "Please enter address";
  static String ENTER_COUNTER_OR_AREA = "Please enter country or area";
  static String COUNTER_OR_AREA = "Country/Area";
  static String ENTER_PHONE_NUMBER = "Please enter phone number";
  static String TIP_PHONE_NUMBER = "Allow area code, such as +86";
  static String PHONE_NUMBER = "Phone number";
  static String ENTER_CONSIGNEE_NAME = "Please enter consignee name";
  static String CONSIGNEE = "Consignee";
  static String DEFAULT = "Default";
  static String ADD_ADDRESS = "Add address";

  static String RATING = "Rating";
  static String COMMENT_CONTENT = "Comment content";
  static String EDIT_COMMENT = "Edit comment";
  static String ADD_COMMENT = "Add comment";
  static String REQUIRE_COMMENT_CONTENT = "Require comment content";

  static String ADDRESS = "Address";
  static String BUY = "Buy";
  static String PAY = "PAY";
  static String FILL_IN_THE_ORDER = "Fill in the order";
  static String SETTLEMENT = "Settlement";
  static String NEED_SELECT_COVER_BY_ADD_MEDIA =
      "Need select cover by add media";
  static String NO_SUPPORT_FILE_TYPE = "Does not support file type";
  static String ONLY_SUPPORT = "Only support";
  static String ENTER_COMMENT = "Enter Comment";
  static String POST_DETAIL = "Post Detail";
  static String EMPTY_CONTENT = "Empty Content";
  static String PLEASE_ENTER_HEADING = "Please enter heading";
  static String PLEASE_ENTER_DESCRIPTION = "Please enter description";
  static String CHOOSE_AS_COVER = "Choose as cover";
  static String COMPLETE = "Complete";
  static String GENERATE = "Generate";
  static String RANDOM = "Random";
  static String SKIP_TO = "Skip to";
  static String SELECT_VIDEO_THUMBNAIL = "Select video thumbnail";
  static String ACTUAL_PAID = "Actual paid";
  static String COMPLETED = "Completed";
  static String CANCELLED = "Cancelled";
  static String TO_PAY = "To Pay";
  static String TO_SHIP = "To Ship";
  static String TO_RECEIVE = "To Receive";
  static String TO_COMMENT = "To Comment";
  static String REFUNDS_SALES = "Refunds/Sales";
  static String REQUESTING = "Requesting";
  static String REFUND_SUCCESSULLY = "Refund Successfully";
  static String REFUND_OF_GOODS = "Refund Of Goods";
  static String REQUEST_CANCELLED = "Request Canceled";
  static String ADD_TO_SHOPPING_CART_SUCCESS =
      "Add to shooping cart successfully";
  static String SHARE_FAILED = "Share failed";
  static String SHARE_SUCCESSFULLY = "Share Successfully";
  static String DELETE_SUCCESSFULLY = "Delete Successfully";
  static String ASK_WANT_TO_DELETE_COMMENT =
      "Are you sure do you want to delete this review ? ";
  static String DELETE = "Delete";
  static String SHRINK = "shrink";
  static String EXPAND = "expand";
  static String VIEW_ALL = "View all";
  static String NO_MORE_COMMENT_YET = "No more comments yet";
  static String PRODUCT_COMMENT = "Product Comment";
  static String NO_COMMENT_YET = "No comments yet";
  static String IMAGE_VIEW = "Image View";
  static String FREE_SHIPING = "Free Shiping";
  static String NO_MORE = "No More";
  static String ENTER_OLD_PASSWORD = "Entry old password";
  static String ENTER_NEW_PASSWORD = "Entry new password";
  static String ENTER_CONFIRM_PASSWORD = "Entry confirm password";
  static String SEND = "Send";
  static String ENTER_DESCRIPTION = "Enter Description";
  static String ENTER_TITLE = "Enter Title";
  static String MY_SETTINGS = "My Settings";
  static String ENTER_MESSAGE = "Enter Message";
  static String SELECT_VIDEO = "Select Video";
  static String SELECT_IMAGE = "Select Image";
  static String SELECT_FILE = "Select File";
  static String NEED_SELECT_MEDIA = "NEED_SELECT_MEDIA";
  static String ERROR_NETWORK_TIMEOUT = "ERROR_NETWORK_TIMEOUT";
  static String ERROR_NETWORK_SERVER = "ERROR_NETWORK_SERVER";
  static String ERROR_NETWORK_CLIENT = "ERROR_NETWORK_CLIENT";
  static String ERROR_NETWORK = "ERROR_NETWORK";
  static String ERROR_CLIENT = "ERROR_CLIENT";
  static String HELLO_WORLD = "hello_world";
  static String ESG_Vida = "ESG_Vida";
  static String Latest_News = "Latest_News";
  static String Reels_Sharing = "Reels_Sharing";
  static String ADD = "Add";
  static String Home = "Home";
  static String Chat = "Chat";
  static String Share = "Share";
  static String Market = "Market";
  static String Profile = "Profile";
  static String ME = "Me";
  static String ALL = "ALL";
  static String LATEST = "LATEST";
  static String SELF = "SELF";
  static String Photo_Taking = "Photo Taking";
  static String Video_Taking = "Video Taking";
  static String Media = "Media";
  static String Max_10picsChoose = "Max. 10 pics to choose";
  static String EDIT = "Edit";
  static String Heading = "Heading";
  static String Enter = "Enter";
  static String Description = "Description";
  static String Search = "Search";
  static String Merchant = "Merchant";
  static String More = "More";
  static String ShopProductList = "Shop Product List";
  static String Product = "Product";
  static String Products = "Products";
  static String Listing = "Listing";
  static String Name = "Name";
  static String Price = "Price";
  static String Submit = "Submit";
  static String Select = "Select";
  static String File = "File";
  static String Image = "Image";
  static String Video = "Video";
  static String Please = "Please";
  static String My = "My";
  static String OrderList = "OrderList";
  static String WISHLIST = "WishList";
  static String SHOPPING_CART = "Shopping Cart";
  static String History = "History";
  static String Sharing = "Sharing";
  static String Favorites = "Favourites";
  static String Language = "Language";
  static String Setting = "Setting";
  static String PushNotification = "Push Notification";
  static String ChangePassword = "Change Password";
  static String ChangePasswordNote =
      "Note : After update password you need to login again";
  static String Logout = "Logout";
  static String GreatDayComes = "Great day comes with Aspiration";
  static String ComeBackSoon = "Come back soon!";
  static String AreYouSureLogout = "Are you sure you want to Log Out?";
  static String CANCEL = "Cancel";
  static String Japnese = "Japanese";
  static String Chinese = "Traditional-Chinese";
  static String English = "English";
  static String Old = "Old";
  static String New = "New";
  static String CONFIRM = "Confirm";
  static String News = "News";
  static String Details = "Details";
  static String Sports = "Sports";
  static String COMMENT = "Comment";
  static String shop = "shop";
  static String Filters = "Filters";
  static String years = "years";
  static String Comments = "Comments";
  static String Introduction = "Introduction";
  static String ADD_TO_SHOPPING_CART = "Add to Shopping Cart";
  static String TIP_ADD_TO_SHOPPING_CART =
      "Are you sure do you want to add this product to your shopping cart ?";
  static String NoCommentFound = "No commends available!";
}

class EnLanguage {
  Map<String, String> enLanguage = {
    LanguageGlobalVar.SET_TO_DEFAULT_ADDRESS:
        LanguageGlobalVar.SET_TO_DEFAULT_ADDRESS,
    LanguageGlobalVar.ENTER_ADDRESS: LanguageGlobalVar.ENTER_ADDRESS,
    LanguageGlobalVar.ENTER_COUNTER_OR_AREA:
        LanguageGlobalVar.ENTER_COUNTER_OR_AREA,
    LanguageGlobalVar.COUNTER_OR_AREA: LanguageGlobalVar.COUNTER_OR_AREA,
    LanguageGlobalVar.ENTER_PHONE_NUMBER: LanguageGlobalVar.ENTER_PHONE_NUMBER,
    LanguageGlobalVar.TIP_PHONE_NUMBER: LanguageGlobalVar.TIP_PHONE_NUMBER,
    LanguageGlobalVar.PHONE_NUMBER: LanguageGlobalVar.PHONE_NUMBER,
    LanguageGlobalVar.ENTER_CONSIGNEE_NAME:
        LanguageGlobalVar.ENTER_CONSIGNEE_NAME,
    LanguageGlobalVar.CONSIGNEE: LanguageGlobalVar.CONSIGNEE,
    LanguageGlobalVar.DEFAULT: LanguageGlobalVar.DEFAULT,
    LanguageGlobalVar.ADD_ADDRESS: LanguageGlobalVar.ADD_ADDRESS,
    LanguageGlobalVar.ADDRESS: LanguageGlobalVar.ADDRESS,
    LanguageGlobalVar.BUY: LanguageGlobalVar.BUY,
    LanguageGlobalVar.PAY: LanguageGlobalVar.PAY,
    LanguageGlobalVar.FILL_IN_THE_ORDER: LanguageGlobalVar.FILL_IN_THE_ORDER,
    LanguageGlobalVar.SETTLEMENT: LanguageGlobalVar.SETTLEMENT,
    LanguageGlobalVar.NEED_SELECT_COVER_BY_ADD_MEDIA:
        LanguageGlobalVar.NO_SUPPORT_FILE_TYPE,
    LanguageGlobalVar.NO_SUPPORT_FILE_TYPE:
        LanguageGlobalVar.NO_SUPPORT_FILE_TYPE,
    LanguageGlobalVar.ONLY_SUPPORT: LanguageGlobalVar.ONLY_SUPPORT,
    LanguageGlobalVar.ENTER_COMMENT: LanguageGlobalVar.ENTER_COMMENT,
    LanguageGlobalVar.POST_DETAIL: LanguageGlobalVar.POST_DETAIL,
    LanguageGlobalVar.EMPTY_CONTENT: LanguageGlobalVar.EMPTY_CONTENT,
    LanguageGlobalVar.PLEASE_ENTER_HEADING:
        LanguageGlobalVar.PLEASE_ENTER_HEADING,
    LanguageGlobalVar.PLEASE_ENTER_DESCRIPTION:
        LanguageGlobalVar.PLEASE_ENTER_DESCRIPTION,
    LanguageGlobalVar.CHOOSE_AS_COVER: LanguageGlobalVar.CHOOSE_AS_COVER,
    LanguageGlobalVar.COMPLETE: LanguageGlobalVar.COMPLETE,
    LanguageGlobalVar.GENERATE: LanguageGlobalVar.GENERATE,
    LanguageGlobalVar.RANDOM: LanguageGlobalVar.RANDOM,
    LanguageGlobalVar.SKIP_TO: LanguageGlobalVar.SKIP_TO,
    LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL:
        LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL,
    LanguageGlobalVar.ACTUAL_PAID: LanguageGlobalVar.ACTUAL_PAID,
    LanguageGlobalVar.CANCELLED: LanguageGlobalVar.CANCELLED,
    LanguageGlobalVar.COMPLETED: LanguageGlobalVar.COMPLETED,
    LanguageGlobalVar.TO_PAY: LanguageGlobalVar.TO_PAY,
    LanguageGlobalVar.TO_SHIP: LanguageGlobalVar.TO_SHIP,
    LanguageGlobalVar.TO_RECEIVE: LanguageGlobalVar.TO_RECEIVE,
    LanguageGlobalVar.TO_COMMENT: LanguageGlobalVar.TO_COMMENT,
    LanguageGlobalVar.REFUNDS_SALES: LanguageGlobalVar.REFUNDS_SALES,
    LanguageGlobalVar.REQUESTING: LanguageGlobalVar.REQUESTING,
    LanguageGlobalVar.REFUND_SUCCESSULLY: LanguageGlobalVar.REFUND_SUCCESSULLY,
    LanguageGlobalVar.REFUND_OF_GOODS: LanguageGlobalVar.REFUND_OF_GOODS,
    LanguageGlobalVar.REQUEST_CANCELLED: LanguageGlobalVar.REQUEST_CANCELLED,
    LanguageGlobalVar.ADD_TO_SHOPPING_CART_SUCCESS:
        LanguageGlobalVar.ADD_TO_SHOPPING_CART_SUCCESS,
    LanguageGlobalVar.SHARE_FAILED: LanguageGlobalVar.SHARE_FAILED,
    LanguageGlobalVar.SHARE_SUCCESSFULLY: LanguageGlobalVar.SHARE_SUCCESSFULLY,
    LanguageGlobalVar.DELETE_SUCCESSFULLY:
        LanguageGlobalVar.DELETE_SUCCESSFULLY,
    LanguageGlobalVar.ASK_WANT_TO_DELETE_COMMENT:
        LanguageGlobalVar.ASK_WANT_TO_DELETE_COMMENT,
    LanguageGlobalVar.DELETE: LanguageGlobalVar.DELETE,
    LanguageGlobalVar.SHRINK: LanguageGlobalVar.SHRINK,
    LanguageGlobalVar.EXPAND: LanguageGlobalVar.EXPAND,
    LanguageGlobalVar.VIEW_ALL: LanguageGlobalVar.VIEW_ALL,
    LanguageGlobalVar.NO_MORE_COMMENT_YET:
        LanguageGlobalVar.NO_MORE_COMMENT_YET,
    LanguageGlobalVar.PRODUCT_COMMENT: LanguageGlobalVar.PRODUCT_COMMENT,
    LanguageGlobalVar.NO_COMMENT_YET: LanguageGlobalVar.NO_COMMENT_YET,
    LanguageGlobalVar.IMAGE_VIEW: LanguageGlobalVar.IMAGE_VIEW,
    LanguageGlobalVar.FREE_SHIPING: LanguageGlobalVar.FREE_SHIPING,
    LanguageGlobalVar.NO_MORE: LanguageGlobalVar.NO_MORE,
    LanguageGlobalVar.ENTER_OLD_PASSWORD: LanguageGlobalVar.ENTER_OLD_PASSWORD,
    LanguageGlobalVar.ENTER_NEW_PASSWORD: LanguageGlobalVar.ENTER_NEW_PASSWORD,
    LanguageGlobalVar.ENTER_CONFIRM_PASSWORD:
        LanguageGlobalVar.ENTER_CONFIRM_PASSWORD,
    LanguageGlobalVar.SEND: LanguageGlobalVar.SEND,
    LanguageGlobalVar.ENTER_DESCRIPTION: LanguageGlobalVar.ENTER_DESCRIPTION,
    LanguageGlobalVar.ENTER_TITLE: LanguageGlobalVar.ENTER_TITLE,
    LanguageGlobalVar.ENTER_MESSAGE: LanguageGlobalVar.ENTER_MESSAGE,
    LanguageGlobalVar.SELECT_VIDEO: LanguageGlobalVar.SELECT_VIDEO,
    LanguageGlobalVar.SELECT_IMAGE: LanguageGlobalVar.SELECT_IMAGE,
    LanguageGlobalVar.SELECT_FILE: LanguageGlobalVar.SELECT_FILE,
    LanguageGlobalVar.NEED_SELECT_MEDIA: "Please select a media at least!",
    Gender.male.label: Gender.male.label,
    Gender.female.label: Gender.female.label,
    Gender.other.label: Gender.other.label,
    LanguageGlobalVar.ERROR_NETWORK_TIMEOUT: 'Network Timeout',
    LanguageGlobalVar.ERROR_NETWORK_SERVER: 'Network server error',
    LanguageGlobalVar.ERROR_NETWORK_CLIENT: 'Network client error',
    LanguageGlobalVar.ERROR_NETWORK: 'Network error',
    LanguageGlobalVar.ERROR_CLIENT: 'client error',
    LanguageGlobalVar.HELLO_WORLD: 'Hello World',
    LanguageGlobalVar.ESG_Vida: "ESG-Vida",
    LanguageGlobalVar.Latest_News: "Latest News",
    LanguageGlobalVar.Reels_Sharing: "Reels Sharing",
    LanguageGlobalVar.ADD: "Add",
    LanguageGlobalVar.Home: "Home",
    LanguageGlobalVar.Chat: "Chat",
    LanguageGlobalVar.Share: "Share",
    LanguageGlobalVar.Market: "Market",
    LanguageGlobalVar.ME: "Me",
    LanguageGlobalVar.Profile: "Profile",
    LanguageGlobalVar.ALL: "ALL",
    LanguageGlobalVar.LATEST: "LATEST",
    LanguageGlobalVar.SELF: "SELF",
    LanguageGlobalVar.Photo_Taking: "Photo Taking",
    LanguageGlobalVar.Video_Taking: "Video Taking",
    LanguageGlobalVar.Media: "Media",
    LanguageGlobalVar.Max_10picsChoose: "Max. 10 pics to choose",
    LanguageGlobalVar.EDIT: "Edit",
    LanguageGlobalVar.Heading: "Heading",
    LanguageGlobalVar.Description: "Description",
    LanguageGlobalVar.Enter: "Enter",
    LanguageGlobalVar.Search: "Search",
    LanguageGlobalVar.Merchant: "Merchant",
    LanguageGlobalVar.More: "More",
    LanguageGlobalVar.ShopProductList: "Shop Product List",
    LanguageGlobalVar.Product: "Product",
    LanguageGlobalVar.Products: "Products",
    LanguageGlobalVar.Video: "Video",
    LanguageGlobalVar.Image: "Image",
    LanguageGlobalVar.File: "File",
    LanguageGlobalVar.Select: "Select",
    LanguageGlobalVar.Submit: "Submit",
    LanguageGlobalVar.Price: "Price",
    LanguageGlobalVar.Name: "Name",
    LanguageGlobalVar.Listing: "Listing",
    LanguageGlobalVar.Please: "Please",
    LanguageGlobalVar.My: "My",
    LanguageGlobalVar.OrderList: "OrderList",
    LanguageGlobalVar.WISHLIST: LanguageGlobalVar.WISHLIST,
    LanguageGlobalVar.SHOPPING_CART: LanguageGlobalVar.SHOPPING_CART,
    LanguageGlobalVar.History: "History",
    LanguageGlobalVar.Sharing: "Sharing",
    LanguageGlobalVar.Favorites: "Favourites",
    LanguageGlobalVar.Language: "Language",
    LanguageGlobalVar.Setting: "Setting",
    LanguageGlobalVar.PushNotification: "Push Notification",
    LanguageGlobalVar.ChangePassword: "Change Password",
    LanguageGlobalVar.ChangePasswordNote: LanguageGlobalVar.ChangePasswordNote,
    LanguageGlobalVar.Logout: "Logout",
    LanguageGlobalVar.GreatDayComes: "Great day comes with Aspiration",
    LanguageGlobalVar.ComeBackSoon: "Come back soon!",
    LanguageGlobalVar.AreYouSureLogout: "Are you sure you want to Log Out?",
    LanguageGlobalVar.CANCEL: LanguageGlobalVar.CANCEL,
    LanguageGlobalVar.English: "English",
    LanguageGlobalVar.Japnese: "Japanese",
    LanguageGlobalVar.Chinese: "Traditional-Chinese",
    LanguageGlobalVar.Old: "Old",
    LanguageGlobalVar.New: "New",
    LanguageGlobalVar.CONFIRM: "Confirm",
    LanguageGlobalVar.News: "News",
    LanguageGlobalVar.Details: "Details",
    LanguageGlobalVar.Sports: "Sports",
    LanguageGlobalVar.COMMENT: "Comment",
    LanguageGlobalVar.shop: "Shop",
    LanguageGlobalVar.Filters: "Filters",
    LanguageGlobalVar.years: "years",
    LanguageGlobalVar.Comments: "Comments",
    LanguageGlobalVar.Introduction: "Introduction",
    LanguageGlobalVar.ADD_TO_SHOPPING_CART:
        LanguageGlobalVar.ADD_TO_SHOPPING_CART,
    LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART:
        LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART,
    LanguageGlobalVar.NoCommentFound: "No commends available!",
  };
}

class JPLanguage {
  Map<String, String> jplanguage = {
    LanguageGlobalVar.SET_TO_DEFAULT_ADDRESS: "デフォルトアドレスに設定",
    LanguageGlobalVar.ENTER_ADDRESS: "詳細なアドレスを入力",
    LanguageGlobalVar.ENTER_COUNTER_OR_AREA: "国または地域を入力してください",
    LanguageGlobalVar.COUNTER_OR_AREA: "国/エリア",
    LanguageGlobalVar.ENTER_PHONE_NUMBER: "携帯電話番号を入力",
    LanguageGlobalVar.TIP_PHONE_NUMBER: "有効なエクステント番号（+86など）",
    LanguageGlobalVar.PHONE_NUMBER: "携帯番号",
    LanguageGlobalVar.ENTER_CONSIGNEE_NAME: "受取人名を入力してください",
    LanguageGlobalVar.CONSIGNEE: "荷受人",
    LanguageGlobalVar.DEFAULT: "デフォルト",
    LanguageGlobalVar.ADD_ADDRESS: "アドレスを追加",
    LanguageGlobalVar.ADDRESS: "アドレス",
    LanguageGlobalVar.BUY: "買う",
    LanguageGlobalVar.PAY: "支払い",
    LanguageGlobalVar.FILL_IN_THE_ORDER: "注文書の記入",
    LanguageGlobalVar.SETTLEMENT: "決済",
    LanguageGlobalVar.NEED_SELECT_COVER_BY_ADD_MEDIA: "メディアを追加して表紙を選択する必要があります",
    LanguageGlobalVar.NO_SUPPORT_FILE_TYPE: "ファイルタイプはサポートされていません",
    LanguageGlobalVar.ONLY_SUPPORT: "サポートのみ",
    LanguageGlobalVar.ENTER_COMMENT: "コメントの入力",
    LanguageGlobalVar.POST_DETAIL: "投稿の詳細",
    LanguageGlobalVar.EMPTY_CONTENT: "空のコンテンツ",
    LanguageGlobalVar.PLEASE_ENTER_HEADING: "タイトルを入力してください",
    LanguageGlobalVar.PLEASE_ENTER_DESCRIPTION: "説明を入力してください",
    LanguageGlobalVar.CHOOSE_AS_COVER: "表紙にする",
    LanguageGlobalVar.COMPLETE: "完了",
    LanguageGlobalVar.GENERATE: "生成",
    LanguageGlobalVar.RANDOM: "ランダム",
    LanguageGlobalVar.SKIP_TO: "ジャンプ先",
    LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL: "ビデオサムネイルの選択",
    LanguageGlobalVar.ACTUAL_PAID: "実際の支払い",
    LanguageGlobalVar.CANCELLED: "キャンセル済み",
    LanguageGlobalVar.COMPLETED: "完了",
    LanguageGlobalVar.TO_PAY: "支払い待ち",
    LanguageGlobalVar.TO_SHIP: "発送待ち",
    LanguageGlobalVar.TO_RECEIVE: "受け取り待ち",
    LanguageGlobalVar.TO_COMMENT: "レビュー待ち",
    LanguageGlobalVar.REFUNDS_SALES: "返品/返金",
    LanguageGlobalVar.REQUESTING: "申請中",
    LanguageGlobalVar.REFUND_SUCCESSULLY: "返金に成功しました",
    LanguageGlobalVar.REFUND_OF_GOODS: "返品に成功しました",
    LanguageGlobalVar.REQUEST_CANCELLED: "申請はキャンセルされました",
    LanguageGlobalVar.ADD_TO_SHOPPING_CART_SUCCESS: "ショッピングカートに追加されました",
    LanguageGlobalVar.SHARE_FAILED: "共有に失敗しました",
    LanguageGlobalVar.SHARE_SUCCESSFULLY: "正常に共有しました",
    LanguageGlobalVar.DELETE_SUCCESSFULLY: "删除成功",
    LanguageGlobalVar.ASK_WANT_TO_DELETE_COMMENT: "このレビューを削除してもよろしいですか?",
    LanguageGlobalVar.DELETE: "消去",
    LanguageGlobalVar.EXPAND: "もっと見る",
    LanguageGlobalVar.VIEW_ALL: "すべて見る",
    LanguageGlobalVar.NO_MORE_COMMENT_YET: "まだコメントはありません",
    LanguageGlobalVar.PRODUCT_COMMENT: "商品コメント",
    LanguageGlobalVar.NO_COMMENT_YET: "まだコメントはありません",
    LanguageGlobalVar.FREE_SHIPING: "送料無料",
    LanguageGlobalVar.NO_MORE: "これ以上ありません",
    LanguageGlobalVar.ENTER_OLD_PASSWORD: "古いパスワードを入力します",
    LanguageGlobalVar.ENTER_NEW_PASSWORD: "新しいパスワードを入力します",
    LanguageGlobalVar.ENTER_CONFIRM_PASSWORD: "確認パスワードを入力します",
    LanguageGlobalVar.SEND: "発送します",
    LanguageGlobalVar.ENTER_DESCRIPTION: "記述を入力します",
    LanguageGlobalVar.ENTER_TITLE: "タイトルを入力します",
    LanguageGlobalVar.MY_SETTINGS: "私の設定です",
    LanguageGlobalVar.ENTER_MESSAGE: "メッセージを入力します",
    LanguageGlobalVar.SELECT_VIDEO: "選択ビデオ",
    LanguageGlobalVar.SELECT_IMAGE: "選択画像",
    LanguageGlobalVar.SELECT_FILE: "選択ファイル",
    LanguageGlobalVar.NEED_SELECT_MEDIA: "少なくともメディアを選択してください!",
    Gender.male.label: "男性",
    Gender.female.label: "女性",
    Gender.other.label: "その他です",
    LanguageGlobalVar.ERROR_NETWORK_TIMEOUT: 'ネットワークタイムアウトです',
    LanguageGlobalVar.ERROR_NETWORK_SERVER: 'サービス側ネットワークエラー',
    LanguageGlobalVar.ERROR_NETWORK_CLIENT: 'クライアントネットワークエラー',
    LanguageGlobalVar.ERROR_NETWORK: 'クライアントエラー',
    LanguageGlobalVar.ERROR_CLIENT: 'クライアントエラー',
    LanguageGlobalVar.HELLO_WORLD: 'こんにちは世界',
    LanguageGlobalVar.ESG_Vida: "ESG-Vida",
    LanguageGlobalVar.Latest_News: "最新ニュース",
    LanguageGlobalVar.Reels_Sharing: "リールの共有",
    LanguageGlobalVar.ADD: "追加",
    LanguageGlobalVar.Home: "ホームページです",
    LanguageGlobalVar.Chat: "チャット",
    LanguageGlobalVar.Share: "共有",
    LanguageGlobalVar.Market: "市場",
    LanguageGlobalVar.ME: "私のです",
    LanguageGlobalVar.Profile: "個人センターです",
    LanguageGlobalVar.ALL: "全て",
    LanguageGlobalVar.LATEST: "一番新しいです",
    LanguageGlobalVar.SELF: "自己",
    LanguageGlobalVar.Photo_Taking: "写真撮影",
    LanguageGlobalVar.Video_Taking: "ビデオ撮影",
    LanguageGlobalVar.Media: "メディア",
    LanguageGlobalVar.Max_10picsChoose: "最大。 選べる10枚の写真",
    LanguageGlobalVar.EDIT: "編集",
    LanguageGlobalVar.Heading: "見出し",
    LanguageGlobalVar.Description: "説明",
    LanguageGlobalVar.Enter: "入力します",
    LanguageGlobalVar.Search: "検索",
    LanguageGlobalVar.Merchant: "商人です",
    LanguageGlobalVar.More: "もっと",
    LanguageGlobalVar.ShopProductList: "ショップ商品一覧",
    LanguageGlobalVar.Product: "製品",
    LanguageGlobalVar.Products: "製品",
    LanguageGlobalVar.Video: "ビデオ",
    LanguageGlobalVar.Image: "画像",
    LanguageGlobalVar.File: "ファイル",
    LanguageGlobalVar.Select: "選択する",
    LanguageGlobalVar.Submit: "提出する",
    LanguageGlobalVar.Price: "価格",
    LanguageGlobalVar.Name: "名前",
    LanguageGlobalVar.Listing: "リスト",
    LanguageGlobalVar.Please: "お願いします",
    LanguageGlobalVar.My: "私の",
    LanguageGlobalVar.OrderList: "受注リスト",
    LanguageGlobalVar.WISHLIST: "希望リスト",
    LanguageGlobalVar.SHOPPING_CART: "ショッピングカート",
    LanguageGlobalVar.History: "歴史",
    LanguageGlobalVar.Sharing: "共有",
    LanguageGlobalVar.Favorites: "お気に入り",
    LanguageGlobalVar.Language: "言語",
    LanguageGlobalVar.Setting: "設定",
    LanguageGlobalVar.PushNotification: "プッシュ通知です",
    LanguageGlobalVar.ChangePassword: "パスワードを変更します",
    LanguageGlobalVar.ChangePasswordNote: "注意:更新パスワードの後、再度ログインする必要があります",
    LanguageGlobalVar.Logout: "ログアウト",
    LanguageGlobalVar.GreatDayComes: "素晴らしい一日には願望が伴います",
    LanguageGlobalVar.ComeBackSoon: "すぐに帰る！",
    LanguageGlobalVar.AreYouSureLogout: "ログアウトしてもよろしいですか?",
    LanguageGlobalVar.CANCEL: "キャンセル",
    LanguageGlobalVar.English: "English",
    LanguageGlobalVar.Japnese: "日本語",
    LanguageGlobalVar.Chinese: "繁体字中国語",
    LanguageGlobalVar.Old: "古い",
    LanguageGlobalVar.New: "新しい",
    LanguageGlobalVar.CONFIRM: "確認する",
    LanguageGlobalVar.News: "ニュース",
    LanguageGlobalVar.Details: "詳細",
    LanguageGlobalVar.Sports: "スポーツ",
    LanguageGlobalVar.COMMENT: "コメント",
    LanguageGlobalVar.shop: "店",
    LanguageGlobalVar.Filters: "フィルター",
    LanguageGlobalVar.years: "年",
    LanguageGlobalVar.Comments: "コメント",
    LanguageGlobalVar.Introduction: "導入",
    LanguageGlobalVar.ADD_TO_SHOPPING_CART: "カートに追加する",
    LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART: "この商品をショッピングカートに追加してもよろしいですか?",
    LanguageGlobalVar.NoCommentFound: "賞賛はありません!",
  };
}

class ChLanguage {
  Map<String, String> chlanguage = {
    LanguageGlobalVar.SET_TO_DEFAULT_ADDRESS: "設定為默認地址",
    LanguageGlobalVar.ENTER_ADDRESS: "請輸入地址",
    LanguageGlobalVar.ENTER_COUNTER_OR_AREA: "請輸入國家或者地區",
    LanguageGlobalVar.COUNTER_OR_AREA: "國家/地區",
    LanguageGlobalVar.ENTER_PHONE_NUMBER: "請輸入電話號碼",
    LanguageGlobalVar.TIP_PHONE_NUMBER: "允許輸入地區碼，如+86",
    LanguageGlobalVar.PHONE_NUMBER: "電話號碼",
    LanguageGlobalVar.ENTER_CONSIGNEE_NAME: "請輸入收貨人名稱",
    LanguageGlobalVar.CONSIGNEE: "收貨人",
    LanguageGlobalVar.DEFAULT: "默認",
    LanguageGlobalVar.ADD_ADDRESS: "添加地址",
    LanguageGlobalVar.ADDRESS: "地址",
    LanguageGlobalVar.BUY: "購買",
    LanguageGlobalVar.PAY: "支付",
    LanguageGlobalVar.FILL_IN_THE_ORDER: "填寫訂單",
    LanguageGlobalVar.SETTLEMENT: "結算",
    LanguageGlobalVar.NEED_SELECT_COVER_BY_ADD_MEDIA: "需要通過添加媒體來選擇封面",
    LanguageGlobalVar.NO_SUPPORT_FILE_TYPE: "不支持文件類型",
    LanguageGlobalVar.ONLY_SUPPORT: "僅支持",
    LanguageGlobalVar.ENTER_COMMENT: "輸入評論",
    LanguageGlobalVar.POST_DETAIL: "帖子詳情",
    LanguageGlobalVar.EMPTY_CONTENT: "空內容",
    LanguageGlobalVar.PLEASE_ENTER_HEADING: "請輸入標題",
    LanguageGlobalVar.PLEASE_ENTER_DESCRIPTION: "請輸入描述",
    LanguageGlobalVar.CHOOSE_AS_COVER: "選作封面",
    LanguageGlobalVar.COMPLETE: "完成",
    LanguageGlobalVar.GENERATE: "生成",
    LanguageGlobalVar.RANDOM: "隨機",
    LanguageGlobalVar.SKIP_TO: "跳轉",
    LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL: "選擇視頻縮略圖",
    LanguageGlobalVar.ACTUAL_PAID: "實際支付",
    LanguageGlobalVar.CANCELLED: "已取消",
    LanguageGlobalVar.COMPLETED: "已完成",
    LanguageGlobalVar.TO_PAY: "待付款",
    LanguageGlobalVar.TO_SHIP: "待發貨",
    LanguageGlobalVar.TO_RECEIVE: "待收貨",
    LanguageGlobalVar.TO_COMMENT: "待評價",
    LanguageGlobalVar.REFUNDS_SALES: "退款/售後",
    LanguageGlobalVar.REQUESTING: "申請中",
    LanguageGlobalVar.REFUND_SUCCESSULLY: "退款成功",
    LanguageGlobalVar.REFUND_OF_GOODS: "退貨成功",
    LanguageGlobalVar.REQUEST_CANCELLED: "申請已取消",
    LanguageGlobalVar.ADD_TO_SHOPPING_CART_SUCCESS: '加入購物車成功',
    LanguageGlobalVar.SHARE_FAILED: '分享失敗',
    LanguageGlobalVar.SHARE_SUCCESSFULLY: '分享成功',
    LanguageGlobalVar.DELETE_SUCCESSFULLY: '删除成功',
    LanguageGlobalVar.ASK_WANT_TO_DELETE_COMMENT: '您確定要刪除此評論嗎？',
    LanguageGlobalVar.DELETE: '刪除',
    LanguageGlobalVar.SHRINK: '收縮',
    LanguageGlobalVar.EXPAND: '展開',
    LanguageGlobalVar.VIEW_ALL: '查看全部',
    LanguageGlobalVar.NO_MORE_COMMENT_YET: '暫時無更多評論',
    LanguageGlobalVar.PRODUCT_COMMENT: '商品評論',
    LanguageGlobalVar.NO_COMMENT_YET: '暫無評論',
    LanguageGlobalVar.IMAGE_VIEW: '圖片',
    LanguageGlobalVar.FREE_SHIPING: '免運費',
    LanguageGlobalVar.NO_MORE: '没有更多了',
    LanguageGlobalVar.ENTER_OLD_PASSWORD: '輸入新密碼',
    LanguageGlobalVar.ENTER_NEW_PASSWORD: '輸入舊密碼',
    LanguageGlobalVar.ENTER_CONFIRM_PASSWORD: '輸入確認密碼',
    LanguageGlobalVar.SEND: '發送',
    LanguageGlobalVar.ENTER_DESCRIPTION: '輸入描述',
    LanguageGlobalVar.ENTER_TITLE: '輸入標題',
    LanguageGlobalVar.MY_SETTINGS: '我的設置',
    LanguageGlobalVar.ENTER_MESSAGE: '輸入消息',
    LanguageGlobalVar.SELECT_VIDEO: '選擇視頻',
    LanguageGlobalVar.SELECT_IMAGE: '選擇圖像',
    LanguageGlobalVar.SELECT_FILE: '選擇文件',
    LanguageGlobalVar.NEED_SELECT_MEDIA: '請至少選擇一個媒體！',
    Gender.male.label: "男",
    Gender.female.label: "女",
    Gender.other.label: "其他",
    LanguageGlobalVar.ERROR_NETWORK_CLIENT: '客戶端網絡錯誤',
    LanguageGlobalVar.ERROR_NETWORK: '網絡錯誤',
    LanguageGlobalVar.ERROR_NETWORK_TIMEOUT: '網絡超時',
    LanguageGlobalVar.ERROR_NETWORK_SERVER: '服務端網絡錯誤',
    LanguageGlobalVar.ERROR_CLIENT: '客戶端錯誤',
    LanguageGlobalVar.HELLO_WORLD: '你好世界',
    LanguageGlobalVar.ESG_Vida: "ESG-Vida",
    LanguageGlobalVar.Latest_News: "最新消息",
    LanguageGlobalVar.Reels_Sharing: "訊息共享",
    LanguageGlobalVar.ADD: "添加",
    LanguageGlobalVar.Home: "主页",
    LanguageGlobalVar.Chat: "聊天",
    LanguageGlobalVar.Share: "分享",
    LanguageGlobalVar.Market: "市場",
    LanguageGlobalVar.ME: "我的",
    LanguageGlobalVar.Profile: "個人中心",
    LanguageGlobalVar.ALL: "全部",
    LanguageGlobalVar.LATEST: "最新",
    LanguageGlobalVar.SELF: "自己",
    LanguageGlobalVar.Photo_Taking: "拍照",
    LanguageGlobalVar.Video_Taking: "影片拍攝",
    LanguageGlobalVar.Media: "媒體",
    LanguageGlobalVar.Max_10picsChoose: "最大限度。 10張照片可供選擇",
    LanguageGlobalVar.EDIT: "編輯",
    LanguageGlobalVar.Heading: "標題",
    LanguageGlobalVar.Description: "描述",
    LanguageGlobalVar.Enter: "輸入",
    LanguageGlobalVar.Search: "搜尋",
    LanguageGlobalVar.Merchant: "商家",
    LanguageGlobalVar.More: "更多",
    LanguageGlobalVar.ShopProductList: "店鋪 產品 列表",
    LanguageGlobalVar.Product: "產品",
    LanguageGlobalVar.Products: "產品",
    LanguageGlobalVar.Video: "影片",
    LanguageGlobalVar.Image: "影像",
    LanguageGlobalVar.File: "文件",
    LanguageGlobalVar.Select: "選擇",
    LanguageGlobalVar.Submit: "提交",
    LanguageGlobalVar.Price: "價格",
    LanguageGlobalVar.Name: "姓名",
    LanguageGlobalVar.Listing: "清單",
    LanguageGlobalVar.Please: "請",
    LanguageGlobalVar.My: "我的",
    LanguageGlobalVar.OrderList: "訂單清單",
    LanguageGlobalVar.WISHLIST: "願望清單",
    LanguageGlobalVar.SHOPPING_CART: "購物車",
    LanguageGlobalVar.History: "歷史",
    LanguageGlobalVar.Sharing: "分享",
    LanguageGlobalVar.Favorites: "收藏夾",
    LanguageGlobalVar.Language: "語言",
    LanguageGlobalVar.Setting: "環境",
    LanguageGlobalVar.PushNotification: "推送通知",
    LanguageGlobalVar.ChangePassword: "更改密碼",
    LanguageGlobalVar.ChangePasswordNote: "注意：更新密碼後需要重新登錄",
    LanguageGlobalVar.Logout: "登出",
    LanguageGlobalVar.GreatDayComes: "美好的一天伴隨著渴望而來",
    LanguageGlobalVar.ComeBackSoon: "很快回來！",
    LanguageGlobalVar.AreYouSureLogout: "您確定要退出嗎？",
    LanguageGlobalVar.CANCEL: "取消",
    LanguageGlobalVar.English: "English",
    LanguageGlobalVar.Japnese: "日本人",
    LanguageGlobalVar.Chinese: "繁體中文",
    LanguageGlobalVar.Old: "古い",
    LanguageGlobalVar.New: "新しい",
    LanguageGlobalVar.CONFIRM: "確認",
    LanguageGlobalVar.News: "訊息",
    LanguageGlobalVar.Details: "詳情",
    LanguageGlobalVar.Sports: "運動的",
    LanguageGlobalVar.COMMENT: "評論",
    LanguageGlobalVar.shop: "店鋪",
    LanguageGlobalVar.Filters: "過濾器",
    LanguageGlobalVar.years: "年",
    LanguageGlobalVar.Comments: "評論",
    LanguageGlobalVar.Introduction: "介紹",
    LanguageGlobalVar.ADD_TO_SHOPPING_CART: "加入購物車",
    LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART: "您確定要將此產品加入您的購物車嗎？",
    LanguageGlobalVar.NoCommentFound: "没有可用的赞扬！",
  };
}
