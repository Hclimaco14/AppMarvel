//
//  ComicDetailWorker.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

class ComicDetailWorker {
    
    private let serviceMager: ServiceMaganerProtocol
    
    public init(serviceManager: ServiceMaganerProtocol = ServicesManager()) {
        self.serviceMager = serviceManager
    }
    
    
    func getComic(request: ComicDetail.Request,_ result: @escaping(Result<ComicDetail.Response.ComicDetail, RequestError>) -> Void)  {
        
        guard let request  = NetworkUtils.createRequest(urlString: "comics/\(request.idComic)", HTTPMethod: .get) else { return }
        serviceMager.fetchRequest(with: request, completion: result)
    }
    
}
