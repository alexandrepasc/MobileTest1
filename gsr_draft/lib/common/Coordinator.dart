class Coordinator {

  String _id;
  String _username;
  String _name;
  String _notes;

  Coordinator(String _id, String _username, String _name, String _notes) {
    setId(_id);
    setUsername(_username);
    setName(_name);
    setNotes(_notes);
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
}