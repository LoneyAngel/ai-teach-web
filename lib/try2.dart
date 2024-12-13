// Future<void> _sendRequest() async {
//   String input = _controller.text;
//   if (input.isEmpty) return;
//
//
//   //构建请求
//   Uri url = Uri.parse('http://localhost:5000/hello');
//   Map<String, String> queryParams = {'message': input};
//   String queryString = Uri(queryParameters: queryParams).query;
//   Uri requestUrl = Uri.parse('$url?$queryString');
//
//   //发出请求
//   try {
//     final response = await http.get(requestUrl);
//     if (response.statusCode == 200) {
//       var responseBody = jsonDecode(response.body);
//       setState(() {
//         _response = responseBody['message'] ?? 'No response';
//       });
//     } else {
//       setState(() {
//         _response = 'Failed to fetch data';
//       });
//     }
//   } catch (e) {
//     setState(() {
//       _response = 'Request failed: $e';
//     });
//   }
// }


