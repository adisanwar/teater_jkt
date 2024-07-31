class Url {
  // static const baseUrl = 'https://9e19-2404-8000-1027-759b-48cf-1a87-f6a8-da5c.ngrok-free.app/api';
  static const baseUrl = 'http://10.107.253.100:3000/api';
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
