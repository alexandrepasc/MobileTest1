import 'dart:core';
import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../Locator.dart';
import '../service/FileService.dart';
import '../service/NavigationService.dart';

final NavigationService _navigationService = locator<NavigationService>();

Widget adminDrawer(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) => Drawer(
    child: ListView(
        children: <Widget>[
          /*drawerHead(_profile),
          drawerDashboard(_profile, _selected, context),
          drawerCoaches(_profile, _selected, context),
          drawerStudents(_profile, _selected, context),
          drawerClasses(_profile, _selected, context),*/
          ...listDrawer(_profile, _selected, context),
        ],
    ),
);

Widget adminAccountDrawerHead(Profile _profile) => UserAccountsDrawerHeader(
  accountName: Text(getAccName(_profile)),
  accountEmail: Text(_profile.getUsername()),
  currentAccountPicture: CircleAvatar(
    backgroundColor: appDarkRedColor,
    child: Text(
      getAccImg(_profile),
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
  ),
);

String getAccName(Profile _profile) {
  if (isUser(_profile.getRoles())) {
    return _profile.getCoachFirstName() + " " + _profile.getCoachLastName();
  } else {
    return _profile.getName();
  }
}

String getAccImg(Profile _profile) {
  if (isUser(_profile.getRoles())) {
    return _profile.getCoachFirstName().substring(0, 1);
  } else {
    return _profile.getName().substring(0, 1);
  }
}

Widget adminDashboardButtonHandle(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_selected != AdminDrawerListEnum.dashboard) {
    return adminDashboardButton(_profile, context);
  } else {
    return adminDashboardButtonSelected();
  }
}

Widget adminDashboardButton(Profile _profile, BuildContext context) => Card(
  child: ListTile(
    title: Text(
      dashboardTitle,
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.pop(context);
      _navigationService.navigateTo(routes.dashboardPageTag, arguments: _profile);
    },
  ),
);

Widget adminDashboardButtonSelected() => Card(
  child: ListTile(
    title: Text(
      dashboardTitle,
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
  color: appDarkRedColor,
);

Widget userDashboardButtonHandle(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_selected != AdminDrawerListEnum.userdashboard) {
    return userDashboardButton(_profile, context);
  } else {
    return userDashboardButtonSelected();
  }
}

Widget userDashboardButton(Profile _profile, BuildContext context) => Card(
  child: ListTile(
    title: Text(
      dashboardTitle,
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.pop(context);
      _navigationService.navigateTo(routes.userDashboardPageTag, arguments: _profile);
    },
  ),
);

Widget userDashboardButtonSelected() => Card(
  child: ListTile(
    title: Text(
      dashboardTitle,
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
  color: appDarkRedColor,
);

Widget adminCoachesButtonHandle(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_selected != AdminDrawerListEnum.coaches) {
    return adminCoachesButton(_profile, context);
  } else {
    return adminCoachesButtonSelected();
  }
}

Widget adminCoachesButton(Profile _profile, BuildContext context) => Card(
  child: ListTile(
    title: Text(
      coachesTitle,
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.pop(context);
      _navigationService.navigateTo(routes.adminCoachesListPageTag, arguments: _profile);
    },
  ),
);

Widget adminCoachesButtonSelected() => Card(
  child: ListTile(
    title: Text(
      coachesTitle,
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
  color: appDarkRedColor,
);

Widget adminStudentsButtonHandle(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_selected != AdminDrawerListEnum.students) {
    return adminStudentsButton(_profile, context);
  } else {
    return adminCoachesButtonSelected();
  }
}

Widget adminStudentsButton(Profile _profile, BuildContext context) => Card(
  child: ListTile(
    title: Text(
      studentsTitle,
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
);

Widget adminStudentsButtonSelected() => Card(
  child: ListTile(
    title: Text(
      studentsTitle,
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
  color: appDarkRedColor,
);

Widget adminClassesButtonHandle(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_selected != AdminDrawerListEnum.classes) {
    return adminClassesButton(_profile, context);
  } else {
    return adminClassesButtonSelected();
  }
}

Widget adminClassesButton(Profile _profile, BuildContext context) => Card(
  child: ListTile(
    title: Text(
      classesTitle,
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
);

Widget adminClassesButtonSelected() => Card(
  child: ListTile(
    title: Text(
      classesTitle,
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
  color: appDarkRedColor,
);

Widget logoutButton(BuildContext context) => Card(
  child: ListTile(
    title: Text(
      "Logout",
      style: TextStyle(
        color: appDarkRedColor,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      doLogoutAction(context);
    },
  ),
);

doLogoutAction(BuildContext context) {

  deleteFile();

  Navigator.pop(context);
  _navigationService.navigateToAndRemove(routes.loginPageTag);
}

Widget drawerHead(Profile _profile) {
  return adminAccountDrawerHead(_profile);
}

Widget drawerDashboard(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (isAdmin(_profile.getRoles())) {
    return adminDashboardButtonHandle(_profile, _selected, context);
  } else if (isUser(_profile.getRoles())) {
    return userDashboardButtonHandle(_profile, _selected, context);
  }
}

Widget drawerCoaches(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_profile.getRoles().contains("ROLE_ADMIN")) {
    return adminCoachesButtonHandle(_profile, _selected, context);
  } else {

  }
}

Widget drawerStudents(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_profile.getRoles().contains("ROLE_ADMIN")) {
    return adminStudentsButtonHandle(_profile, _selected, context);
  } else {

  }
}

Widget drawerClasses(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  if (_profile.getRoles().contains("ROLE_ADMIN")) {
    return adminClassesButtonHandle(_profile, _selected, context);
  } else {

  }
}

Widget drawerMySessions(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  
}

List<Widget> listDrawer(Profile _profile, AdminDrawerListEnum _selected, BuildContext context) {
  List<Widget> _list = new List();

  if (drawerHead(_profile) != null) {
    _list.add(drawerHead(_profile));
  }

  if (drawerDashboard(_profile, _selected, context) != null) {
    _list.add(drawerDashboard(_profile, _selected, context));
  }
  
  if (drawerCoaches(_profile, _selected, context) != null) {
    _list.add(drawerCoaches(_profile, _selected, context));
  }

  if(drawerStudents(_profile, _selected, context) != null) {
    _list.add(drawerStudents(_profile, _selected, context));
  }
  
  if (drawerClasses(_profile, _selected, context) != null) {
    _list.add(drawerClasses(_profile, _selected, context));
  }

  if () {

  }

  _list.add(logoutButton(context));

  return _list;
}