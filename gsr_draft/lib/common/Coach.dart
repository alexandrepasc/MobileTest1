class Coach {

  String _id;
  String _firstName;
  String _lastName;
  String _description;
  String _authId;

  Coach(String _id, String _firstName, String _lastName, String _description, String _authId) {
    setId(_id);
    setFirstName(_firstName);
    setLastName(_lastName);
    setDescription(_description);
    setAuthId(_authId);
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

  getDescription() {
    return _description;
  }

  setDescription(String _description) {
    this._description = _description;
  }

  getAuthId() {
    return _authId;
  }

  setAuthId(String _authId) {
    this._authId = _authId;
  }

}