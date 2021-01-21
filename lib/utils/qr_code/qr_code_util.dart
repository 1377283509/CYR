import 'dart:typed_data';
import 'package:qrscan/qrscan.dart' as qrscan;

// 扫码
Future<String> scan() async {
  try{
    String res = await qrscan.scan();
    return res;
  }catch(e){
    return null;
  }
}

// 生成二维码
Future<Uint8List> generateQrCode(String content)async{
  Uint8List res = await qrscan.generateBarCode(content);
  return res;
}
