import 'Auth.dart';
import 'Class.dart';
import 'Coach.dart';
import 'Coordinator.dart';
import 'Session.dart';
import 'Student.dart';

class Profile {

  String token;
  String id;
  String username;
  String name;
  List<String> roles;

  String _coachId;
  String _coachFirstName;
  String _coachLastName;
  String _coachDescription;

  Session _session;
  Class _class;
  Student _student;
  Coordinator _coordinator;
  Coach _coach;
  Auth _auth;

  Profile({
    this.token,
    this.id,
  });

  getToken() {
    return token;
  }

  setToken(String token) {
    this.token = token;
  }

  getId() {
    return id;
  }

  setId(String id) {
    this.id = id;
  }

  getUsername() {
    return username;
  }

  setUsername(String username) {
    this.username = username;
  }

  getName() {
    return name;
  }

  setName(String name) {
    this.name = name;
  }

  getRoles() {
    return roles;
  }

  setRoles(List<String> roles) {
    this.roles = roles;
  }

  getCoachId() {
    return _coachId;
  }

  setCoachId(String _coachId) {
    this._coachId = _coachId;
  }

  getCoachFirstName() {
    return _coachFirstName;
  }

  setCoachFirstName(String _coachFirstName) {
    this._coachFirstName = _coachFirstName;
  }

  getCoachLastName() {
    return _coachLastName;
  }

  setCoachLastName(String _coachLastName) {
    this._coachLastName = _coachLastName;
  }

  getCoachDescription() {
    return _coachDescription;
  }

  setCoachDescription(String _coachDescription) {
    this._coachDescription = _coachDescription;
  }

  getSession() {
    return _session;
  }

  setSession(Session _session) {
    this._session = _session;
  }

  getClass() {
    return _class;
  }

  setClass(Class _class) {
    this._class = _class;
  }

  getStudent() {
    return _student;
  }

  setStudent(Student _student) {
    this._student = _student;
  }

  getCoordinator() {
    return _coordinator;
  }

  setCoordinator(Coordinator _coordinator) {
    this._coordinator = _coordinator;
  }

  getCoach() {
    return _coach;
  }

  setCoach(Coach _coach) {
    this._coach = _coach;
  }

  getAuth() {
    return _auth;
  }

  setAuth(Auth _auth) {
    this._auth = _auth;
  }
}