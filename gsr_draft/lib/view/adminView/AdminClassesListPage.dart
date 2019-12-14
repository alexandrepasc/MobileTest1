import 'package:flutter/material.dart';

import 'package:gsr_draft/model/ClassModel.dart' as clasModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Class.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../Locator.dart';
import '../../model/ClassModel.dart';
import '../../service/ClassService.dart';
import '../../service/NavigationService.dart';

class AdminClassesListPage extends StatefulWidget {
  final Profile profile;

  AdminClassesListPage({Key key, this.profile}) : super(key: key);

  _AdminClassesListPage createState() => _AdminClassesListPage();
}

class _AdminClassesListPage extends State<AdminClassesListPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.classes, context),
      body: Scrollbar(
          child: Center(
            child: Text("classes"),
          )
      ),
    );
  }
  
  ClassesModel _classesModel;
  
  /*Future _apiGetClasses(String token) async {
    
    await 
  }*/
}