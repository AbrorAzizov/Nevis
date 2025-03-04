
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExternalLinks {
   static final String _baseUrl = dotenv.env['DOCS_URL']!;
   static final String bonusProgrammUrl = '${_baseUrl}programma-loyalnosti-vasha-karta-cashback/';
   static final String orderInstructionUrl = '${_baseUrl}instruktsiya-po-oformleniyu-zakaza-na-sayte/';
   static final String privacyPolicyUrl = '${_baseUrl}personal-data/';
   static final String bookingRulesUrl = '${_baseUrl}pravila-bronirovaniya-i-dostavki/';
   static final String userAgreement = '${_baseUrl}polzovatelskoe-soglashenie.php/';
}



//https://aptekanevis.ru/polzovatelskoe-soglashenie.php
// 1) Правило бонусной программы:
// https://aptekanevis.ru/instruction/programma-loyalnosti-vasha-karta-cashback/

// 2) Инструкция по оформлению заказа на сайте
//  https://aptekanevis.ru/instruction/instruktsiya-po-oformleniyu-zakaza-na-sayte/

// 3) Политика обработки персональных данных
// https://aptekanevis.ru/instruction/personal-data/

// 4) Правила бронирования товаров
// https://aptekanevis.ru/instruction/pravila-bronirovaniya-i-dostavki/