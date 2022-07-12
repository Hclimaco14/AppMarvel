//
//  ComicHomeWorker.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

class ComicHomeWorker {
    
    private let serviceMager: ServiceMaganerProtocol
    
    public init(serviceManager: ServiceMaganerProtocol = ServicesManager()) {
        self.serviceMager = serviceManager
    }
    
    func getComics(result: @escaping(Result<ComicHome.Response.Comics, RequestError>) -> Void) {
        guard let request  = NetworkUtils.createRequest(urlString: "comics", HTTPMethod: .get) else { return }
        serviceMager.fetchRequest(with: request, completion: result)
    }
    
}
