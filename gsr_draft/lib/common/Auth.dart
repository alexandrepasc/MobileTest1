class Auth {

  String _id;
  String _username;
  String _name;
  String _notes;
  List<String> _roles;

  Auth(String _id, String _username, String _name, String _notes, List<String> _roles) {
    setId(_id);
    setUsername(_username);
    setName(_name);
    setNotes(_notes);
    setRoles(_roles);
  }

  getId() {
    return _id;
  }

  setId(String _id) {
    this._id = _id;
  }

  getUsername() {
    return _username;
  }

  setUsername(String _username) {
    this._username = _username;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }

  getNotes() {
    return _notes;
  }

  setNotes(String _notes) {
    this._notes = _notes;
  }

  getRoles() {
    return _roles;
  }

  setRoles(List<String> _roles) {
    this._roles = _roles;
  }
}