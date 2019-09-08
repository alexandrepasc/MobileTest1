class Profile {

  String token;

  Profile({
    this.token,
  });

  getToken() {
    return token;
  }

  setToken(String token) {
    this.token = token;
  }
}