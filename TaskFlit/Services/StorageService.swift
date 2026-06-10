//
//  StorageService.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

class StorageService {
    
    static func loadMockTasks() -> [TaskItem] {
        
        guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
            print("o xcode nao embutiu o arquivo no app")
            return []
        }
        
        print("arquivo encontrado \(url)")
        
        do {
            let data = try Data(contentsOf: url)
            print("lendo os bytes (Tamanho: \(data.count) bytes)")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let tasks = try decoder.decode([TaskItem].self, from: data)
            print("os bytes foram convertidos em \(tasks.count) objetos de tarefa.")
            return tasks
            
        } catch {
            print("erro de sintaxe / detalhe: \(error)")
            return []
        }
    }
}
