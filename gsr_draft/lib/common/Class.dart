class Class {

  String _id;
  String _name;
  String _description;
  String _coachId;
  List<String> _students;

  Class(String _id, String _name, String _description, String _coachId, List<String> _students) {
    setId(_id);
    setName(_name);
    setDescription(_description);
    setCoachId(_coachId);
    setStudents(_students);
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

  getDescription() {
    return _description;
  }

  setDescription(String _description) {
    this._description = _description;
  }

  getCoachId() {
    return _coachId;
  }

  setCoachId(String _coachId) {
    this._coachId = _coachId;
  }

  getStudents() {
    return _students;
  }

  setStudents(List<String> _students) {
    this._students = _students;
  }
}