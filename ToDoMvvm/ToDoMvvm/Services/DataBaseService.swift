//
//  File.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import Foundation

class DataBaseService {
    
    static let storageKEy = "DataBaseService"
    
    private let userDefaults = UserDefaults.standard
    
    var elementsData: [ToDoElementModel]
    
    static let shared = DataBaseService()
    
    private init() {
        self.elementsData = []
    }
 
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
    
}
