class ApiResponse {
  final String date;
  final int id;
  final String idDevice;
  final String ipCliente;
  final String name;
  final int status;

  ApiResponse({
    required this.date,
    required this.id,
    required this.idDevice,
    required this.ipCliente,
    required this.name,
    required this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      date: json['date'],
      id: json['id'],
      idDevice: json['id_device'],
      ipCliente: json['ip_cliente'],
      name: json['name'],
      status: json['status'],
    );
  }
}
