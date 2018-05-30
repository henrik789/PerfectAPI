//
//  GarageMain.swift
//  COpenSSL
//
//  Created by Henrik on 2018-05-17.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()
let garage = Garage()
let car = Car(model: "", colour: "", value: "", regNumber: "")

// Create the container variable for routes to be added to.
var routes = Routes()

//// Register your own routes and handlers
//// This is an example "Hello, world!" HTML route
//routes.add(method: .get, uri: "/", handler: {
//    request, response in
//    // Setting the response content type explicitly to text/html
//    response.setHeader(.contentType, value: "text/html")
//    // Adding some HTML to the response body object
//    response.appendBody(string: "<html><title>Hello, Garage!</title><body><h1>Hello, Garage!</h1></body></html>")
//    // Signalling that the request is completed
//    response.completed()
//}
//)


// Adding a route to handle the GET garage list URL
routes.add(method: .get, uri: "/Garage", handler: {
    request, response in
    print(garage.data.count)
    // Setting the response content type explicitly to application/json
    response.setHeader(.contentType, value: "application/json")
    // Setting the body response to the JSON list generated
    response.appendBody(string: garage.list())
    // Signalling that the request is completed
    response.completed()
}
)

// Adding a route to handle the POST garage add URL, with post body params
routes.add(method: .post, uri: "/Garage", handler: {
    request, response in
    
    // Setting the response content type explicitly to application/json
    response.setHeader(.contentType, value: "application/json")
    // Adding a new "person", passing the complete HTTPRequest object to the function.
    response.appendBody(string: garage.add(request))
    // Signalling that the request is completed
    response.completed()
}
)

//// Adding a route to handle the POST people add via JSON
//routes.add(method: .post, uri: "/Garage/json", handler: {
//    request, response in
//
////    let garage = Garage()
//
//    // Setting the response content type explicitly to application/json
//    response.setHeader(.contentType, value: "application/json")
//    // Adding a new "person", passing the just the request's post body as a raw string to the function.
//    response.appendBody(string: garage.add(request.postBodyString!))
//    // Signalling that the request is completed
//    response.completed()
//}
//)

// Adding a route to Delete the POST garage add URL, with post body params
routes.add(method: .delete, uri: "/Garage/{regid}", handler: {
    request, response in
    
    
    if let regid = request.urlVariables["regid"]{
        garage.removeCar(regId: regid)
    }
    
    // garage.removeCar(regid)
    // Setting the response content type explicitly to application/json
    response.setHeader(.contentType, value: "application/json")
    // Adding a new "person", passing the complete HTTPRequest object to the function.
    response.appendBody(string: garage.list())
    // Signalling that the request is completed
    response.completed()
}
)

// Adding a route to handle the GET garage list URL & gets a single cars parameters based on regnumber
routes.add(method: .get, uri: "/Garage/{regid}", handler: {
    request, response in
    
    if let regid = request.urlVariables["regid"], let index = garage.findCarNrBy(regnr: regid){
        let carInGarage = garage.data[index].getData()
        response.appendBody(string: carInGarage)
    }
    
    // Setting the response content type explicitly to application/json
    response.setHeader(.contentType, value: "application/json")
    // Setting the body response to the JSON list generated
    
    // Signalling that the request is completed
    response.completed()
}
)





// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

do {
    // Launch the HTTP server.
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
