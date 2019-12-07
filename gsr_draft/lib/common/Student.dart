class Student {

  String _id;
  String _firstName;
  String _lastName;
  int _birthDate;
  String _description;
  ActiveClass _activeClass;
  List<String> _classes;

  Student(String _id, String _firstName, String _lastName, int _birthDate,
      String _description, ActiveClass _activeClass, List<String> _classes) {

    setId(_id);
    setFirstName(_firstName);
    setLastName(_lastName);
    setBirthDate(_birthDate);
    setDescription(_description);
    setActiveClass(_activeClass);
    setClasses(_classes);
  }

  getId() {
    return _id;
  }

  setId(String _id) {
    this._id = _id;
  }

  getFirstName() {
    return _firstName;
  }

  setFirstName(String _firstName) {
    this._firstName = _firstName;
  }

  getLastName() {
    return _lastName;
  }

  setLastName(String _lastName) {
    this._lastName = _lastName;
  }

  getBirthDate() {
    return _birthDate;
  }

  setBirthDate(int _birthDate) {
    this._birthDate = _birthDate;
  }

  getDescription() {
    return _description;
  }

  setDescription(String _description) {
    this._description = _description;
  }

  getActiveClass() {
    return _activeClass;
  }

  setActiveClass(ActiveClass _activeClass) {
    this._activeClass = _activeClass;
  }

  getClasses() {
    return _classes;
  }

  setClasses(List<String> _classes) {
    this._classes = _classes;
  }
}

class ActiveClass {

  String _id;
  String _name;

  ActiveClass(String _id, String _name) {
    setId(_id);
    setName(_name);
  }

  getId() {
    return _id;
  }

  setId(String _id) {
    this._id = _id;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }
 }