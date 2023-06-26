//
//  File.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import Foundation
import FirebaseFirestore

class DataBaseService {
        
    static let storageKEy = "DataBaseService"
    
    private let userDefaults = UserDefaults.standard
    
    private let fireBase = Firestore.firestore()
    
    var elementsData: [ToDoElementModel]
    var elementsForFireBase = [ToDoElementModel]()

    static let shared = DataBaseService()
    
    private init() {
        self.elementsData = []
    }
 
    //MARK: - UserDefaults
    func readData() -> [ToDoElementModel] {
        guard let encodedData = userDefaults.data(forKey: DataBaseService.storageKEy) else {
            return []
        }
        do
        {
            let jsonDecoder = JSONDecoder()
            let data = try jsonDecoder.decode([ToDoElementModel].self, from: encodedData)
            return data
        }
        catch
        {
            print("Failled to decode data")
        }
        
        return []
    }
    
    
    func addData(element: ToDoElementModel) -> Bool {
        var temporarContainer = readData()
        temporarContainer.append(element)
        elementsData = temporarContainer
        let boolResult = saveData()
        return boolResult
    }
    
    
    private func saveData() -> Bool {
        let temporarContainer = elementsData
        do
        {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(temporarContainer)
            userDefaults.set(data, forKey: DataBaseService.storageKEy)
            return userDefaults.synchronize()
        }
        catch
        {
            print("Failled to encode data")
        }
        return false
    }
    
    
    func save(dataArray: [ToDoElementModel]) {
        self.elementsData = dataArray
        saveData()
    }
    
    
    func deleteElement(id: UUID) -> Bool {
        var temporarContainer = readData()
        temporarContainer.removeAll(where: {$0.id == id})
        elementsData = temporarContainer
        return saveData()
    }
   
    
    func editElement(element: ToDoElementModel) -> Bool {
        var elementsForEditing = readData()
        guard let index = elementsForEditing.firstIndex(where: {$0.id == element.id}) else { return false }
        
        elementsForEditing[index] = element
        elementsData = elementsForEditing
        return saveData()
    }
    
        //MARK: - FireBase
    
    func readDataFireBase(completion: @escaping([ToDoElementModel]) -> Void) {
        fireBase.collection("toDoElements").getDocuments { querySnapshot, err in
            if let err = err {
                print("Erro to get docs \(err)")
            } else if let  querySnapshot = querySnapshot {
                
                for toDoElement in querySnapshot.documents {
                    let data = toDoElement.data()
                    var newElement = ToDoElementModel()
                    for index in data.keys {
                        guard let element = data[index] as? String else { return }
                        if index == "title" {
                            newElement.title = element
                            
                        } else if index == "information" {
                            newElement.information = element
                            
                        } else if index == "priority" {
                            newElement.priority = .init(rawValue: element) ?? .low
                        }
                        
                    }
                    self.elementsForFireBase.append(newElement)
                }
                
                completion(self.elementsForFireBase)
            }
        }
    }
    
//    func getDataFireBase() {
//        fireBase.collection("toDoElements").getDocuments { (snapshot, _) in
//            let toDoElements = snapshot!.documents
//            try! toDoElements.forEach { toDoElement in
//
//                let element: ToDoFireBase = try toDoElement.decoded()
//                print(element)
//
//            }
//        }
//    }
//
//    func readFireBase(completion: @escaping (Bool, [ToDoFireBase]) -> ()) {
//        var toDoElem = [ToDoFireBase]()
//        fireBase.collection("toDoElements").getDocuments() { (querrySnappshot, err) in
//            if let err = err {
//                print("Error getting documents \(err) ")
//                completion(false, toDoElem)
//            } else {
//                for toDoElement in querrySnappshot!.documents {
//                    let data = toDoElement.data()
//                    toDoElem = data
//                }
//                completion(true, toDoElem)
//                print(toDoElem)
//            }
//        }
//    }
    
   
}
