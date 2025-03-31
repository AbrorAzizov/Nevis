import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class Utils {
  static RegExp phoneRegexp = RegExp(r'^\+7 \d{3} \d{3} \d{2} \d{2}$');

  static TextStyle htmlTextStyle = UiConstants.textStyle2;

  static Style htmlStyle = Style(
    fontSize: FontSize(htmlTextStyle.fontSize!),
    color: UiConstants.darkBlueColor,
    fontWeight: htmlTextStyle.fontWeight!,
    height: Height((htmlTextStyle.height ?? 1) * htmlTextStyle.fontSize!),
    fontFamily: htmlTextStyle.fontFamily,
  );

  static String mockHtml =
      "<blockquote>\r\n<p style=\"text-align: justify;\"><strong>Louis Widmer </strong>&mdash; это швейцарская <strong><a href=\"katalog/gigiena-i-kosmetika/uhod-za-licom/zhirnaya-i-problemnaya-kozha.html\">лечебная косметика</a></strong> для самой чувствительной кожи.</p>\r\n</blockquote>\r\n<p class=\"bx-section-desc-post\" style=\"text-align: justify;\">&nbsp;</p>\r\n<p class=\"bx-section-desc-post\" style=\"text-align: justify;\">Средства созданы в тесном сотрудничестве с лучшими швейцарскими дерматологами, химиками и известными университетами.&nbsp;Эффективные дерматологические компоненты в фармакодинамических дозах.&nbsp;Продукты с минимальным содержанием консервантов либо их полным отсутствием, благодаря стерильности производства.&nbsp;Без парфюмерных отдушек и красителей, очень высокая&nbsp;переносимость людьми&nbsp;страдающими аллергией.&nbsp;&nbsp;Наноэмульсии (биодоступность в 5-10 раз выше обычных микроэмульсий, используемых при производстве косметических средств).&nbsp;Липосомные технологии (доставка активных компонентов и воздействие на клеточном уровне).&nbsp;Ферментированная гиалуроновая кислота, действующая в глубоких слоях кожи.&nbsp;Использование ультразвукового эмульгирования при производстве,&nbsp;позволяет снизить до 60% нежелательное действие эмульгаторов на кожу.<br /><br />В марке представлены гаммы:<br /><br /></p>\r\n<ul>\r\n<li style=\"text-align: justify;\"><b><i>Louis Widmer&nbsp;Очищение&nbsp;</i></b>-&nbsp;&nbsp;нежная, но глубокая очистка. Деликатное очищение для чувствительной кожи. Благодаря активным компонентам (комплекс аминокислот и пантенол) продукты данной гаммы увлажняют и успокаивают.</li>\r\n<li style=\"text-align: justify;\"><b><i>Louis Widmer&nbsp;Уход -&nbsp;</i></b>дневной уход&nbsp;для каждого типа кожи: Крема с ценными биоактивными ингредиентами для дневного ухода. Результат: гладкая и мягкая кожа, меньше морщин, идеальное увлажнение.&nbsp;Ночной уход&nbsp;для каждого типа кожи: интенсивно восстанавливает, смягчает. Крема поддерживают естественный процесс регенерации кожи, улучшают кровообращение и стимулируют обновление тканей.</li>\r\n<li style=\"text-align: justify;\"><b><i>Louis Widmer&nbsp;Скин Эпил (</i></b><b><i>Skin Appeal)&nbsp;</i></b>- линейка для проблемной и жирной кожи.&nbsp;Воздействует на: воспалительные элементы; подавляет размножение Р. Аcnes; обладает&nbsp; противовоспалительным, бактерицидным, противогрибковым, противовирусным и ранозаживляющим действием. НЕ СУШИТ КОЖУ.</li>\r\n<li style=\"text-align: justify;\"><b><i>Louis Widmer&nbsp;Ремедерм (Remederm</i></b><b><i>)&nbsp;</i></b>- интенсивный уход для очень сухой и атопичной кожи младенцев детей и взрослых. Глубоко увлажняет, питает и восстанавливает повреждённые участки кожи.&nbsp;</li>\r\n<li style=\"text-align: justify;\"><b><i>Louis Widmer&nbsp;Солнечная линия (Sun line</i></b><b><i>)</i></b>&nbsp;- гамма идеально подходит <strong><a href=\"katalog/gigiena-i-kosmetika/uhod-za-licom/uhod-za-chuvstvitelnoj-atopichnoj-kozhej.html\">для очень чувствительной кожи</a></strong> и кожи, склонной к аллергическим реакциям.&nbsp;Входящие в состав ухаживающие компоненты эффективно восстанавливают и увлажняют кожу.&nbsp;UVA и UVB фильтры нового поколения предотвращают проявление кожных аллергических реакций и снижают вероятность получения солнечных ожогов.&nbsp;Высокая водостойкость.</li>\r\n</ul>";

  static String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Регулярное выражение для проверки email
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid e-mail address';
    }
    return null; // Если email корректный, возвращаем null (валидация успешна)
  }

  static String formatSecondToMMSS(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  static String removeTrailingZeros(double value, int fractionDigits) {
    // Convert the value to a string with fixed decimal places
    String result = value.toStringAsFixed(fractionDigits).replaceAll('.', ',');

    // Remove trailing zeros
    result = result.replaceAll(RegExp(r"([,]*0+)(?!,*\d)"), "");

    return result;
  }

  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final DateFormat formatter = DateFormat('dd.MM.yyyy в HH:mm');
    return formatter.format(dateTime);
  }

  static String getRussianTypeReceiving(TypeReceiving typeReceiving) {
    switch (typeReceiving) {
      case TypeReceiving.delivery:
        return 'Доставка';
      case TypeReceiving.pickup:
        return 'Самовывоз';

      default:
        return '';
    }
  }

  static String getRussianOrderStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.onTheWay:
        return 'В пути';
      case OrderStatus.readyToIssue:
        return 'Готов к выдаче';
      case OrderStatus.reserved:
        return 'Зарезервирован';
      case OrderStatus.canceled:
        return 'Отменен';
      case OrderStatus.received:
        return 'Получен';
      case OrderStatus.collected:
        return 'Собран';
      case OrderStatus.collecting:
        return 'В сборке';
      case OrderStatus.courierSearching:
        return 'Поиск курьера';
      case OrderStatus.courierWaiting:
        return 'Ожидание курьера';
      case OrderStatus.accepted:
        return 'Принят';
    }
  }

  static String getOrderStatusSubtitle(OrderStatus status, {DateTime? date}) {
    switch (status) {
      case OrderStatus.onTheWay:
        return "Курьер едет к вам";
      case OrderStatus.readyToIssue:
        return "Готов к выдаче";
      case OrderStatus.reserved:
        return "Проверим наличие и свяжемся с вами в случае отсутствия товаров";
      case OrderStatus.received:
        return "Спасибо за заказ";
      case OrderStatus.collected:
        return "Ваш заказ собран, скоро мы передадим его курьеру";
      case OrderStatus.collecting:
        return "Мы уже начали работать с вашим заказом";
      default:
        return '';
    }
  }

  static String getOrderStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.onTheWay:
        return Paths.onTheWayIconPath;
      case OrderStatus.readyToIssue:
        return Paths.readyToIssueIconPath;
      case OrderStatus.reserved:
        return Paths.hourglassIconPath;
      case OrderStatus.received:
        return Paths.readyIconPath;
      case OrderStatus.collected:
        return Paths.boxIconPath;
      case OrderStatus.collecting:
        return Paths.collectingIconPath;
      case OrderStatus.canceled:
        return Paths.cancelIconPath;
      case OrderStatus.courierSearching:
        return Paths.courierSearchingIconPath;
      case OrderStatus.courierWaiting:
        return Paths.courierWaitingIconPath;
      case OrderStatus.accepted:
        return Paths.orderAcceptedIconPath;
    }
  }

  static List<OrderStatus> getOrderStatuses(
      PaymentType? paymentType, TypeReceiving typeReceipt,
      {OrderStatus? orderStatus}) {
    List<OrderStatus> statuses = [];
    print(typeReceipt);
    if (orderStatus == OrderStatus.canceled) {
      statuses = [
        OrderStatus.canceled,
      ];
    } else if (typeReceipt == TypeReceiving.pickup ||
        typeReceipt == TypeReceiving.pickupFromWareHouse) {
      statuses = [
        typeReceipt == TypeReceiving.pickup
            ? OrderStatus.accepted
            : OrderStatus.collecting,
        OrderStatus.readyToIssue,
        OrderStatus.received,
      ];
    } else if (typeReceipt == TypeReceiving.delivery) {
      statuses = [
        OrderStatus.collecting,
        OrderStatus.courierSearching,
        OrderStatus.courierWaiting,
        OrderStatus.onTheWay,
        OrderStatus.received,
      ];
    }

    if (orderStatus == null) {
      statuses.add(OrderStatus.canceled);
    }

    return statuses;
  }

  static Map<String, dynamic> getNotNullFields(Map<String, dynamic> map) {
    return Map.from(map)..removeWhere((key, value) => value == null);
  }

  static String formatPhoneNumber(String? phoneNumber,
      {bool toServerFormat = true}) {
    if (phoneNumber == null || phoneNumber == '') return '';

    if (toServerFormat) {
      final RegExp regex = RegExp(r'^\+7(\d{3})(\d{3})(\d{2})(\d{2})$');
      return phoneNumber.replaceAllMapped(
        regex,
        (match) => '+7 ${match[1]} ${match[2]} ${match[3]} ${match[4]}',
      );
    } else {
      // Преобразование из серверного формата в клиентский
      final RegExp regex = RegExp(r'^\+7(\d{3})-?(\d{3})-?(\d{2})-?(\d{2})$');
      return phoneNumber.replaceAllMapped(
        regex,
        (match) => '+7 (${match[1]}) ${match[2]}-${match[3]}-${match[4]}',
      );
    }
  }

  static void showCustomDialog(
      {required BuildContext screenContext,
      String? title,
      required String text,
      required Function(BuildContext context) action}) {
    showDialog(
      context: screenContext,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            action(context);
            return false; // Предотвращаем автоматическое закрытие
          },
          child: AlertDialog(
            backgroundColor: UiConstants.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? 'Ошибка',
                  style: UiConstants.textStyle5
                      .copyWith(color: UiConstants.blackColor),
                ),
                GestureDetector(
                  onTap: () => action(context),
                  child: Icon(Icons.close,
                      color: UiConstants.blackColor, size: 25.w),
                ),
              ],
            ),
            content: Text(
              text,
              style: UiConstants.textStyle2
                  .copyWith(color: UiConstants.blackColor),
            ),
            actions: [
              AppButtonWidget(
                text: 'Ок',
                onTap: () => action(context),
              ),
            ],
          ),
        );
      },
    );
  }

  static String getProductCountText(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return '$count товар';
    } else if ((count % 10 >= 2 && count % 10 <= 4) &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return '$count товара';
    } else {
      return '$count товаров';
    }
  }

  static String getPharmacyLabel(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return 'аптеке';
    } else if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return 'аптеках';
    } else {
      return 'аптеках';
    }
  }

  static String formatPrice(double? price) {
    if (price == null) return '-';
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'ru_RU', symbol: '₽', decimalDigits: 0);
    return formatter.format(price);
  }

  static Future<BitmapDescriptor> createBitmapIcon({
    int? count,
    String? price,
    bool isSelected = false,
  }) async {
    final ByteData data = await rootBundle.load(
        count == null ? Paths.mapPointPath : Paths.mapPointWithCounterPath);
    final Uint8List list = Uint8List.view(data.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(list);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);
    final paint = Paint();
    canvas.drawImage(image, Offset.zero, paint);

    if (count != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: count.toString(),
          style: TextStyle(
            color: UiConstants.white2Color,
            fontSize: image.height * 0.5, // Сделал текст крупнее
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );

      textPainter.layout();
      final offset = Offset(
        (image.width - textPainter.width) / 2,
        (image.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }

    if (price != null && price.isNotEmpty) {
      final double backgroundWidth = 120;
      final double backgroundHeight = 50;
      final double backgroundX = (image.width - backgroundWidth) / 2;
      final double backgroundY = image.height + 1;

      final RRect backgroundRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
            backgroundX, backgroundY, backgroundWidth, backgroundHeight),
        Radius.circular(40), // Сделал скругление больше
      );

      final Paint backgroundPaint = Paint()
        ..color = isSelected ? UiConstants.blueColor : UiConstants.whiteColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(backgroundRect, backgroundPaint);

      final textPainterPrice = TextPainter(
        text: TextSpan(
          text: "$price ₽",
          style: TextStyle(
            color: isSelected ? UiConstants.whiteColor : UiConstants.blueColor,
            fontSize: 24, // Сделал текст еще больше
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );

      textPainterPrice.layout(maxWidth: backgroundWidth - 16);

      final priceOffset = Offset(
        backgroundX + (backgroundWidth - textPainterPrice.width) / 2,
        backgroundY + (backgroundHeight - textPainterPrice.height) / 2,
      );

      textPainterPrice.paint(canvas, priceOffset);
    }

    final ui.Image newImage =
        await recorder.endRecording().toImage(image.width, image.height + 60);
    final ByteData? newData =
        await newImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List newList = newData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(newList);
  }
}
