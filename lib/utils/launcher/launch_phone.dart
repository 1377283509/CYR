import 'package:url_launcher/url_launcher.dart';

launchPhone(String phone) async {
  String url = "tel:" + phone;
  if(await canLaunch(url)){
    await launch(url);
  }
}