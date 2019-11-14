import 'package:flutter/material.dart';

// Colors
Color appDarkGreyColor = Color.fromRGBO(58, 66, 86, 1.0);
Color appGreyColor = Color.fromRGBO(64, 75, 96, .9);
Color appWhiteColor = Color.fromRGBO(255, 255, 255, 1.0);
Color appDarkRedColor = Color.fromRGBO(170, 0, 0, 1.0);

// Strings
const appTitle = "Galitos Summary Register";
const userNameHintText = "User Name";
const passwordHintText = "Password";
const loginButtonText = "Login";

const dashboardTitle = "Dashboard";
const coachesTitle = "Caoches list";
const studentsTitle = "Students list";
const classesTitle = "Classes list";

// Images
Image appLogo = Image.asset('assets/images/logo.jpg');

// Sizes
const bigRadius = 80.0;
const buttonHeight = 24.0;

// Pages
//const loginPageTag = 'Login Page';
//const dashboardPageTag = 'Dashboard Page';

// API
const apiUrl = "172.17.0.3:8080";
const userEndPoint = "/users/";
const coachesEndPoint = "/coaches";