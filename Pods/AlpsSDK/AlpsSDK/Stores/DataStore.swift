//
//  DataStore.swift
//  AlpsSDK
//
//  Created by Maciej Burda on 19/10/2017.
//  Copyright © 2017 Alps. All rights reserved.
//

import Foundation
import Alps

/// Together with all protocols below defines full CRUD interface for data type model

typealias CRUD = AsyncCreateable & AsyncReadable & AsyncUpdateable & AsyncDeleteable & AsyncClearable
typealias CRD = AsyncCreateable & AsyncReadable & AsyncDeleteable & AsyncClearable

protocol AssociatedDataType {
    associatedtype DataType
    var items: [DataType] { get }
}

protocol AsyncCreateable: AssociatedDataType {
    func create(item: DataType, completion: @escaping (Result<DataType>) -> Void)
}

protocol AsyncReadable: AssociatedDataType {
    func find(byId: String, completion: @escaping (Result<DataType>) -> Void)
    func findAll(completion: @escaping (Result<[DataType]>) -> Void)
}

protocol AsyncUpdateable: AssociatedDataType {
    func update(item: DataType, completion: @escaping (Result<DataType>) -> Void)
}

protocol AsyncDeleteable: AssociatedDataType {
    func delete(item: DataType, completion: @escaping (ErrorResponse?) -> Void)
}

protocol AsyncClearable: AssociatedDataType {
    func deleteAll(completion: @escaping (ErrorResponse?) -> Void)
}
