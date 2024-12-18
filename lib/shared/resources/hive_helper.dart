
import 'package:hive/hive.dart';

class HiveHelper {



   Future openHiveBox({required String nameBox}) async {
    await Hive.openBox(nameBox);
  }



  storeData({required String boxName,required String key ,required dynamic value}) {
    Hive.box(boxName).put(key, value);
  }

  dynamic retrievingData({required String boxName,required String key}){
    return Hive.box(boxName).get(key);
  }
  closeHiveBox({required String boxName}){
    Hive.box(boxName).close();
  }










}
