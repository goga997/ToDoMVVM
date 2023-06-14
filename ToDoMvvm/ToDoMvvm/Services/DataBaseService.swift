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
        self.elementsData = [
            ToDoElementModel(title: "Math", information: "Mathematics is an area of knowledge that includes the topics of numbers, formulas and related structures, shapes and the spaces in which they are contained, and quantities and their changes. These topics are represented in modern mathematics with the major subdisciplines of number theory,[1] algebra,[2] geometry,[1] and analysis,[3][4] respectively. There is no", priority: .high),
            ToDoElementModel(title: "Geography", information: "Geography (from Greek: γεωγραφία, geographia. Combination of Greek words 'Geo' (The Earth) and 'Graphien' (to describe), literally  is a field of science devoted to the study of the lands, features, inhabit", priority: .low),
            ToDoElementModel(title: "English", information: "red", priority: .high),
            ToDoElementModel(title: "History", information: "History is an academic discipline which uses narrative to describe, examine, question, and analyze past events, and investigate their patterns of cause and effect.[6][7] Historians debate which narrative best explains an event, as well as t", priority: .medium),
            ToDoElementModel(title: "Biology", information: "Anatomy is a complex and dynamic field that is constantly evolving as new discoveries are made. In recent years, there has been a significant increase in the use of advanced imaging techniques, such as MRI and CT scans, which allow for more detailed and accurate", priority: .low),
            ToDoElementModel(title: "Astronomy", information: "Yellow", priority: .low),
            ToDoElementModel(title: "Metaol", information: "abraadd", priority: .medium)
        ]
        
        
//        let number = Int()
//        let aaa = String()
//        let ToDoElementModel = ToDoElementModel(title: <#T##String#>, information: <#T##String#>, priority: <#T##Priority#>)
//        let double = Double()
//        let float = Float()
//        let int = Int(from: <#T##Decoder#>)
//        let character = Character()
//        let mainView = MainViewController()
//        let tableViewCell = TableViewCell()
//        let firstNumber = Int(exactly: <#T##Double#>)
//        let stringMY = String(localized: <#T##LocalizedStringResource#>)
//        let stringGG = String(reflecting: <#T##Subject#>)
//        let floatQ = Float(bitPattern: <#T##UInt32#>)
//        let float = Float(nan: <#T##Float.RawSignificand#>, signaling: <#T##Bool#>)
//        let floatW = Float(floatLiteral: <#T##Float#>)
//        let stringGh = String(contentsOf: <#T##URL#>)
//        let stringn = String(codingKey: <#T##CodingKey#>)
//        let stringm = String(contentsOf: <#T##URL#>, encoding: <#T##String.Encoding#>)
//        let stringr = String(contentsOfFile: <#T##String#>, encoding: <#T##String.Encoding#>)
//        let stringc = String(decoding: <#T##Collection#>, as: <#T##_UnicodeEncoding.Protocol#>)
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
    
    
    func addData(element: ToDoElementModel) {
        var temporarContainer = readData()
        temporarContainer.append(element)
        elementsData = temporarContainer
        let result = saveData()
        if result {
            print("Data saved succesfully")
        } else {
            print("Data saved Unsuccesfully")
        }
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
}
