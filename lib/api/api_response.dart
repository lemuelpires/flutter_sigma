class ApiResponse<T>{
  final T? data;
  final String? message;
  final bool success;

  ApiResponse ({this.data, this.message, required this.success});

  factory ApiResponse.success(T data){
      return ApiResponse<T>(data: data, success:true);
  }

  factory ApiResponse.error(String message){
      return ApiResponse<T>(message: message, success: false);
  }

}