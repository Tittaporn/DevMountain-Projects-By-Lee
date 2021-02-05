//
//  Yak.swift
//  YikyYak
//
//  Created by Lee McCormick on 2/4/21.
//

import CloudKit

struct YakStrings {
    static let recordTypeKey = "Yak"
    fileprivate static let textKey = "text"
    fileprivate static let authorKey = "author"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let scoreKey = "score"
    // DO NOT NEED RECORD ID HERE...
}

class Yak {
    let text: String
    let author: String
    let timestamp: Date
    var score: Int
    var recordID: CKRecord.ID
    
    init(text: String, author: String, timestamp: Date = Date(), score: Int = 0, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.score = score
        self.recordID = recordID
    }
}

// Making CKRecord from the Yak
extension CKRecord {
    convenience init(yak: Yak){
        self.init(recordType: YakStrings.recordTypeKey, recordID: yak.recordID)
        self.setValuesForKeys([
            YakStrings.textKey : yak.text,
            YakStrings.authorKey : yak.author,
            YakStrings.timestampKey : yak.timestamp,
            YakStrings.scoreKey : yak.score
        ])
    }
}

// Converting ckRecord to Yak
extension Yak {
    convenience init?(ckRecord: CKRecord) {
        // CKRecord is Type AnyObject, so we are telling it to convert to each Yak type.
        // Dictionary is optional.
        guard let text = ckRecord[YakStrings.textKey] as? String,
              let author = ckRecord[YakStrings.authorKey] as? String,
              let timestamp = ckRecord[YakStrings.timestampKey] as? Date,
              let score = ckRecord[YakStrings.scoreKey] as? Int
              else { return nil } // ALWAYS NEED TO RETURN NIL HERE...
        self.init(text: text, author: author, timestamp: timestamp, score: score, recordID: ckRecord.recordID)
    }
}

extension Yak: Equatable {
    static func == (lhs: Yak, rhs: Yak) -> Bool {
        lhs.recordID == rhs.recordID
    }
}
