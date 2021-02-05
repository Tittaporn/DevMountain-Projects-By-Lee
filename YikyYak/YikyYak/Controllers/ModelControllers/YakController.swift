//
//  YakController.swift
//  YikyYak
//
//  Created by Lee McCormick on 2/4/21.
//

import CloudKit

class YakController {
    
    // MARK: - Properties
    static let shared = YakController()
    var yaks: [Yak] = []
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD Methods
    // CREATE
    func createYak(with text: String, author: String, completion: @escaping (Result<String,YakError>) -> Void) {
        let newYak = Yak(text: text, author: author)
        let record = CKRecord(yak: newYak)
        publicDB.save(record) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let record = record,
                  let savedYak = Yak(ckRecord: record) else { return completion(.failure(.couldNotUpwrap))}
            self.yaks.append(savedYak)
            return completion(.success("Successfully created a Yak."))
        }
    }
    
    // READ
    func fetchAllYaks(completion: @escaping (Result<String,YakError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: YakStrings.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.couldNotUpwrap))}
            // NEED COMPACTMAT TO ASSIGN EACH ARRAY TO YAK
            let fetchYaks = records.compactMap {Yak(ckRecord: $0)}
            
            // To Sorted the Yaks by score.
            let sortedYaks = fetchYaks.sorted(by: {$0.score > $1.score})
            self.yaks = sortedYaks
            return completion(.success("Successfully fetched all Yaks."))
        }
    }
    
    // UPDATE
    func updateYak(yak: Yak, completion: @escaping (Result<Yak,YakError>) -> Void) {
        let record = CKRecord(yak: yak)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys //Passing yak,and update the keys that change in this app is only the score. ==> Other apps can be .allKeys
        operation.qualityOfService = .userInteractive
        
        // (records, recordIDs, error) ==> records, recordIDs, error //() withOut () IS OKAY.
        operation.modifyRecordsCompletionBlock = { (records, recordIDs, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let record = records?.first,
                  let updateYak = Yak(ckRecord: record) else { return completion(.failure(.couldNotUpwrap))}
            return completion(.success(updateYak))
        }
        publicDB.add(operation)
    }
    
    // DELETE
    func delete(yak: Yak, completion: @escaping (Result<String,YakError>) -> Void) {
        // USE CKMODIFYRECORDSOPERATION, NEED RECORD ID.
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [yak.recordID])
        // DO NOT NEED .changedKeys TO Delete because delete it from the cloud
        operation.qualityOfService = .userInteractive//How fast to delete, immediately, we could use .background ==> not really fast, can do it in the background.
        operation.modifyRecordsCompletionBlock = { _, recordIDs, error in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let recordID = recordIDs?.first else { return completion(.failure(.couldNotUpwrap))}
            return completion(.success("Successfully deleted \(recordID.recordName) in CloudKit."))
        }
        publicDB.add(operation)
    }
}
