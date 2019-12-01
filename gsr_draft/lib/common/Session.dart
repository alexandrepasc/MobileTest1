class Session {

  String _id;
  String _classId;
  String _coachId;
  String _name;
  String _summary;
  int _date;
  String _className;

  Session(String _id, String _classId, String _coachId, String _name, String _summary, int _date, String _className) {
    setId(_id);
    setClassId(_classId);
    setCoachId(_coachId);
    setName(_name);
    setSummary(_summary);
    setDate(_date);
    setClassName(_className);
  }

  getId() {
    return _id;
  }

  setId(String _id) {
    this._id = _id;
  }

  getClassId() {
    return _classId;
  }

  setClassId(String _classId) {
    this._classId = _classId;
  }

  getCoachId() {
    return _coachId;
  }

  setCoachId(String _coachId) {
    this._coachId = _coachId;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }

  getSummary() {
    return _summary;
  }

  setSummary(String _summary) {
    this._summary = _summary;
  }

  getDate() {
    return _date;
  }

  setDate(int _date) {
    this._date = _date;
  }

  getClassName() {
    return _className;
  }

  setClassName(String _className) {
    this._className = _className;
  }
}