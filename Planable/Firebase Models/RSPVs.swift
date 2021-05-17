//
//  RSPVs.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import Foundation
import Firebase

class RSPVs {
        var rspvArray: [RSVP] = []

        func loadData(completed: @escaping ()->() ) {
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let documentURL = directoryURL.appendingPathComponent("rsvp").appendingPathExtension("json")

            guard let data = try? Data(contentsOf: documentURL) else {return}
            let jsonDecoder = JSONDecoder()
            do {
                rspvArray = try jsonDecoder.decode(Array<RSVP>.self, from: data)
                
            } catch {
                print("😡 ERROR: Could not load data \(error.localizedDescription)")
            }
            completed() // flag says we are done to run the closure
        }
        
        func saveData() {
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let documentURL = directoryURL.appendingPathComponent("rsvp").appendingPathExtension("json")
            let jsonEncoder = JSONEncoder()
            let data = try? jsonEncoder.encode(rspvArray)
            do {
                try data?.write(to: documentURL, options: .noFileProtection)
            } catch {
                print("😡 ERROR: Could not save data \(error.localizedDescription)")
            }
        }
}
