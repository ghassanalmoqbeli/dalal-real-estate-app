bool isSuxes(String? status) {
  if (isntNull(status)) {
    if (status == 'success') return true;
  }
  return false;
}

bool isNemp(String? value) {
  if (isntNull(value) && isntEmp(value!)) return true;
  return false;
}

bool isntNull(String? value) {
  if (value != null) return true;
  return false;
}

bool isntEmp(String value) => value.isNotEmpty ? true : false;
