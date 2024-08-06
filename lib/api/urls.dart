class Url {
  // static const baseUrl = 'living-newly-seal.ngrok-free.app/api';
  static const baseUrl = 'http://10.107.253.100:3000/api';
  static const baseImgUrl = 'http://10.107.253.100:3000/';
  // static const baseImgUrl = 'http://10.10.1.123:3000/';
  // static const baseUrl = 'http://10.10.1.123:3000/api';
  static const login = '$baseUrl/users/login';
  static const register = '$baseUrl/users';
  static const logout = '$baseUrl/users/current';

  static const getCurrentUsers = '$baseUrl/users/current';
  static const getUsers = '$baseUrl/users/current';
  static const updateUsers = '$baseUrl/users/current';
  static const deleteUsers = '$baseUrl/users/current';

  static const getContact = '$baseUrl/contacts';
  static const createContact = '$baseUrl/contacts';
  static const updateContact = '$baseUrl/contacts';
  static const deleteContact = '$baseUrl/contacts';

  static const getShows = '$baseUrl/shows/current';
  static const createShows = '$baseUrl/shows';
  static const updateShows = '$baseUrl/shows';
  static const deleteShows = '$baseUrl/shows';
}
