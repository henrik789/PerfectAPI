//
//  Car.swift
//  COpenSSL
//
//  Created by Henrik on 2018-05-17.
//

import PerfectLib

class Car : JSONConvertibleObject{
    
    static let registerName = "car"
    
    var regNumber: String = ""
    var colour: String = ""
    var value: String = ""
    var model: String = ""
    
    //    var fullName: String {
    //        return "\(firstName) \(lastName)"
    //    }
    
    init(model: String, colour: String, value: String, regNumber: String) {
        self.model  = model
        self.colour = colour
        self.value  = value
        self.regNumber  = regNumber
    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.model      = getJSONValue(named: "model", from: values, defaultValue: "")
        self.colour     = getJSONValue(named: "colour", from: values, defaultValue: "")
        self.value      = getJSONValue(named: "value", from: values, defaultValue: "")
        self.regNumber  = getJSONValue(named: "regNumber", from: values, defaultValue: "")
    }
    
    func getData() -> String{
        return toString()
    }
    
    private func toString() -> String {
        
        var stringOut = [String]()
        
        do{
            stringOut.append(try self.jsonEncodedString())
        }
        catch{
            print(error)
        }
        return "[\(stringOut.joined(separator: ","))]"
    }
    
    override public func getJSONValues() -> [String : Any] {
        return [
            "model":model,
            "colour":colour,
            "value":value,
            "regNumber":regNumber
        ]
    }
    
    
}
