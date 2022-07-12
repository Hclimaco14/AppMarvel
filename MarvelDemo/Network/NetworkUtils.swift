//
//  NetworkUtils.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation
import CommonCrypto
import SystemConfiguration

public class NetworkUtils {
    
    private static let timeOutInterval: Double = 60
    
    public static func createRequest(urlString: String?, HTTPMethod: HTTPMethod, body: String? =  nil) -> URLRequest?{
        
        var urlStr = "http://gateway.marvel.com/v1/public/"
        
        if let url = urlString {
            urlStr += url
        }
        
        urlStr = self.getAuthentication(urlString: urlStr)
        
        guard let urlConexion = URL(string: urlStr) else { return nil }
        
        var urlRequest = URLRequest(url: urlConexion)
        
        urlRequest.httpMethod = HTTPMethod.rawValue
        urlRequest.timeoutInterval = timeOutInterval
        if let dataBody = body {
            urlRequest.httpBody =  dataBody.data(using: String.Encoding.utf8)
        }
        
        return urlRequest
        
    }
    
    
    static func getAuthentication(urlString: String) -> String {
    
        let dateInt = Int64(Date().timeIntervalSince1970)
        let date = String(dateInt)
        let authenticationParameters:[String:String] = ["ts":date,
                                                        "apikey": Constants.publicKey,
                                                        "hash": (date + Constants.privateKey + Constants.publicKey).MD5() ]
        
        var components = URLComponents(string: urlString)
        
        components?.queryItems = authenticationParameters.map({ URLQueryItem(name: $0.key, value: $0.value)})
        
        return components?.description ?? ""
    }
    
    
}

public extension String {
    
    func MD5() -> String {
        let string = self
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
  
}
