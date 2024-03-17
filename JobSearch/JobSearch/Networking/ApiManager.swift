//
//  ApiManager.swift
//  JobSearch
//
//  Created by User on 16.03.2024.
//

import Foundation

final class ApiManager {
    static func getVacancies(completion: @escaping (Result<[Vacancy], Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/ed41d10e-0c1f-4439-94fa-9702c9d95c14") else { return }
        
        let urlRequest = URLRequest(url: url)
      let session = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    
   static private func handleResponse(data: Data?, error: Error?, completion: @escaping (Result<[Vacancy], Error>) -> Void) {
        if let error {
            completion(.failure(error))
        } else if let data {
            let json = try? JSONSerialization.jsonObject(with: data)
            print(json ?? "")
            do {
                let vacancy = try JSONDecoder().decode(VacanciesModel.self, from: data)
                completion(.success(vacancy.vacancies))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        }
    }
}
