//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Vapor

struct Adventure: Content {
    let placeID: Int
    let Id: Int
    var activityName: String
    var location: String //como implementar: Deve ser igual o location
    var category: Int
    var description: String
    var status: Bool
    var cuidados: [String] //Como deve ser implementado ?
    var contato: String
    var endereço: String //talvez precise usar o maps, então salvar de outra forma
}
