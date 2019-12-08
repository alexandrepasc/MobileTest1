enum Roles {
  ROLE_ADMIN,
  ROLE_COORDINATOR,
  ROLE_USER,
}

const Map<Roles, String> RolesName = {
  Roles.ROLE_ADMIN: "ROLE_ADMIN",
  Roles.ROLE_COORDINATOR: "ROLE_COORDINATOR",
  Roles.ROLE_USER: "ROLE_USER",
};

bool isUser(List<String> roles) {

  if (roles.contains(RolesName[Roles.ROLE_ADMIN])) {
    return false;
  }

  if (roles.contains(RolesName[Roles.ROLE_COORDINATOR])) {
    return false;
  }

  if (roles.contains(RolesName[Roles.ROLE_USER])) {
    return true;
  }

  return false;
}

bool isCoordinator(List<String> roles) {

  if (roles.contains(RolesName[Roles.ROLE_ADMIN])) {
    return false;
  }

  if (roles.contains(RolesName[Roles.ROLE_COORDINATOR])) {
    return true;
  }

  return false;
}

bool hasCoordinator(List<String> roles) {

  if (roles.contains(RolesName[Roles.ROLE_COORDINATOR])) {
    return true;
  } else {
    return false;
  }
}

bool isAdmin(List<String> roles) {

  if (roles.contains(RolesName[Roles.ROLE_ADMIN])) {
    return true;
  }

  return false;
}