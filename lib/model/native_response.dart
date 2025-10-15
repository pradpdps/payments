class NativeResponse {
  bool? success;
  String? message;
  String? data;

  NativeResponse({this.success, this.message, this.data});

  NativeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['success'] = success;
    jsonData['message'] = message;
    jsonData['data'] = data;
    return jsonData;
  }
}