bool isAdmin(String role) {
  return role.toUpperCase() == 'ADMINISTRADOR';
}

bool isEmployee(String role) {
  return role.toUpperCase() == 'EMPLEADO';
}
