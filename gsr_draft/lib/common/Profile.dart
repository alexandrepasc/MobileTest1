class Profile {

  String token;
  String id;

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
}