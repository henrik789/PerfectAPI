//
//  Garage.swift
//  COpenSSL
//
//  Created by Henrik on 2018-05-17.
//

import PerfectHTTP

public class Garage{
    var data = [Car]()
    
    // Populating with a mock data object
    init(){
        data = [
            Car(model: "Volvo V70", colour: "Red", value: "10000", regNumber: "ABC213"),
            Car(model: "Nissan 350Z", colour: "Black", value: "320000", regNumber: "CBA321"),
            Car(model: "Volvo S40", colour: "Orange", value: "78000", regNumber: "AAA111"),
            Car(model: "BMW 320i", colour: "Blue", value: "40000", regNumber: "CCC222")
        ]
    }
    
    // A simple JSON encoding function for listing data members.
    // Ordinarily in an API list directive, cursor commands would be included.
    public func list() -> String {
        return toString()
    }
    
    // Accepts the HTTPRequest object and adds a new Car from post params.
    public func add(_ request: HTTPRequest) -> String {
        let new = Car(
            model: request.param(name: "model") ?? "",
            colour: request.param(name: "colour") ?? "",
            value: request.param(name: "value") ?? "",
            regNumber: request.param(name: "regNumber") ?? ""
            
        )
        data.append(new)
        return toString()
    }
    
    // Accepts raw JSON string, to be converted to JSON and consumed.
    public func add(_ json: String) -> String {
        do {
            let incoming = try json.jsonDecode() as! [String: String]
            let new = Car(
                model: incoming["model"] ?? "",
                colour: incoming["colour"] ?? "",
                value: incoming["value"] ?? "",
                regNumber: incoming["regNumber"] ?? ""
            )
            data.append(new)
        } catch {
            return "ERROR"
        }
        return toString()
    }
    
    //Removes Car from Garage
    public func removeCar(regId: String) {
        if let nr = findCarNrBy(regnr: regId) {
            data.remove(at: nr)
        }
        
    }
    
    func findCarNrBy(regnr: String) -> Int? {
        var i = 0
        for car in data {
            if (car.regNumber == regnr){
                return i
            }
            i += 1
            print(data.count)
        }
        return nil
    }
    
    func getData() -> String{
        return toString()
    }
    
    
    // Convenient encoding method that returns a string from JSON objects.
    private func toString() -> String {
        var out = [String]()
        
        for m in self.data {
            do {
                out.append(try m.jsonEncodedString())
            } catch {
                print(error)
            }
        }
        return "[\(out.joined(separator: ","))]"
    }
    
    
    
    
}
