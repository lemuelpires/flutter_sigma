import 'dart:convert';
import 'package:http/http.dart' as http;

class MelhorEnvioService {
  final String _baseUrl = "https://sandbox.melhorenvio.com.br/api/v2";
  final String _token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NTYiLCJqdGkiOiJhYzJlYTM1ZjE5ZDY3MmY1N2I5NGRhNjhiNWUwZDE5ZjI1NzcwYTQ2NDBlMjU0ZDkwMDA3MWU3MDEyMjAwNjhlNTVlN2Y4YTZmOTgwMTcxMyIsImlhdCI6MTczNTE4NDM4OS4zMTU0NjYsIm5iZiI6MTczNTE4NDM4OS4zMTU0NjksImV4cCI6MTc2NjcyMDM4OS4yOTc3Niwic3ViIjoiOWRkMDY0OTgtZjgzOS00ODJhLTg3MzktODU3ZDZmOGRmYmIwIiwic2NvcGVzIjpbImNhcnQtcmVhZCIsImNhcnQtd3JpdGUiLCJjb21wYW5pZXMtcmVhZCIsImNvbXBhbmllcy13cml0ZSIsImNvdXBvbnMtcmVhZCIsImNvdXBvbnMtd3JpdGUiLCJub3RpZmljYXRpb25zLXJlYWQiLCJvcmRlcnMtcmVhZCIsInByb2R1Y3RzLXJlYWQiLCJwcm9kdWN0cy1kZXN0cm95IiwicHJvZHVjdHMtd3JpdGUiLCJwdXJjaGFzZXMtcmVhZCIsInNoaXBwaW5nLWNhbGN1bGF0ZSIsInNoaXBwaW5nLWNhbmNlbCIsInNoaXBwaW5nLWNoZWNrb3V0Iiwic2hpcHBpbmctY29tcGFuaWVzIiwic2hpcHBpbmctZ2VuZXJhdGUiLCJzaGlwcGluZy1wcmV2aWV3Iiwic2hpcHBpbmctcHJpbnQiLCJzaGlwcGluZy1zaGFyZSIsInNoaXBwaW5nLXRyYWNraW5nIiwiZWNvbW1lcmNlLXNoaXBwaW5nIiwidHJhbnNhY3Rpb25zLXJlYWQiLCJ1c2Vycy1yZWFkIiwidXNlcnMtd3JpdGUiLCJ3ZWJob29rcy1yZWFkIiwid2ViaG9va3Mtd3JpdGUiLCJ3ZWJob29rcy1kZWxldGUiLCJ0ZGVhbGVyLXdlYmhvb2siXX0.Ps5P6evhfkq8TolbMHp_kKPa5nQKcx_VTnFVYCyRWNAwWAwC_N48njfKt_4CsL53LUW-CgafIAte_FonggmX_RPuOqUuxgtLQBAXzGWhPnyM3ELsZ-my-mp-KeCAZuJUgPrMzxXLeZi0kEmquRqEEgVn4RHyKp75yUJfPmfiiO0DpyoKz_q6ymHmlanOjiFtKJpNY3XekbWkxyRSXicstfP1xqZKHoi0VvPBalZaiJbqDAnyJmTyrbHcykpTRziCziEfojG1jAIU-9xgFXIj8bof6acJkpg-oWvZRyL1zEj0gR3dxVPD3PeotAedgEo5a3IjOSLtj1aYiJ-7rx1RadCVx9qE9K69qt74Z_cb51-gIZdcaEo210cx_0XS8BdBJkzn8CRamg5c3hjZ5p_zxg9ilNy7yXh11TVGYAGOFyhqUuP5lvMgXKXvj-dqRVNpnOsJGVAh9HwJPvOtbGzGRBpHRNdDdB-gJr7i6KAKgAVVkBGhGBpqVk7dKbR7GHDsrX59GziBsBQyJE5bdXC2qKqP1gQDQrw_VJPC1BJjGQWKIMricFykfYyYRquWXNbnAvzE8qtnUYBs6uRPD6gwhK6--qRzKX7sEfnvgGZnsblWNyk1g0VaY75EI8IoG98PqPl0Dgyc-TJxWFaWVGQ1T1Ntm-1_Lbb9KU7Yg93kDWA"; // Substitua pelo token gerado

  Future<dynamic> calcularFrete({
    required String cepOrigem,
    required String cepDestino,
    required double peso,
    required double comprimento,
    required double altura,
    required double largura,
    required double valorDeclarado,
  }) async {
    final url = Uri.parse("$_baseUrl/me/shipment/calculate");
    final headers = {
      "Authorization": "Bearer $_token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final body = jsonEncode([
      {
        "from": {"postal_code": cepOrigem},
        "to": {"postal_code": cepDestino},
        "products": [
          {
            "weight": peso,
            "height": altura,
            "width": largura,
            "length": comprimento,
            "insurance_value": valorDeclarado,
            "quantity": 1
          }
        ],
        "services": ["1"], // Serviços (exemplo: "1" para PAC, "2" para SEDEX)
      }
    ]);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Retorna os dados do frete
      } else {
        throw Exception("Erro ao calcular frete: ${response.body}");
      }
    } catch (e) {
      throw Exception("Erro na requisição: $e");
    }
  }
}
