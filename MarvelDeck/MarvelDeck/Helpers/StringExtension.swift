//
//  StringExtension.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension String {
    func asMD5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
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

/* NOTE Import this file for security because the API Require MD5.
 
 https://developer.marvel.com/documentation/authorization
 
 This Marvel API Requair to me a hash...
 
 Authentication for Server-Side Applications
 Server-side applications must pass two parameters in addition to the apikey parameter:
 ts - a timestamp (or other long string which can change on a request-by-request basis)
 hash - a md5 digest of the ts parameter, your private key and your public key (e.g. md5(ts+privateKey+publicKey)
 
 md5 >> It is a hash ??? Move Every letter forward ex. C = E, A = C
 
 //______________________________________________________________________________________
 */
