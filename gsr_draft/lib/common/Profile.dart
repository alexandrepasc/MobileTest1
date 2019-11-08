class Profile {

  String token;
  String id;
  String username;
  String name;
  List<String> roles;

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
}