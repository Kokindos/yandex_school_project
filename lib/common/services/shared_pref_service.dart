import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {

  Future<int> getRevision() async{
    final sharedPref=await SharedPreferences.getInstance();
    int? revision=sharedPref.getInt('network_revisions');
    return revision?? 0;
  }
  Future<bool> saveRevision({required int revision}) async{
    final sharedPref=await SharedPreferences.getInstance();
    return sharedPref.setInt('network_revisions', revision);
  }
}