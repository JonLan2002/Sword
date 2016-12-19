import Foundation
import WebSockets

extension Sword {

  func getGateway(completion: @escaping (Error?, [String: Any]?) -> Void) {
    requester.request(endpoint.gateway, authorization: true) { error, data in
      if error != nil {
        completion(error, nil)
        return
      }

      guard let data = data as? [String: Any] else {
        completion(.unknown, nil)
        return
      }

      completion(nil, data)
    }
  }

  func startWS() {
    try? WebSocket.connect(to: gatewayUrl!) { ws in
      print("Connected to \(self.gatewayUrl!)")

      ws.onText = { ws, text in
        print(text)
      }

      ws.onClose = { ws, _, _, _ in
        print("WS Closed")
      }
    }
  }

}