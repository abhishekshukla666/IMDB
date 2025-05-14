//
//  AuthenticationViewModel.swift
//  IMDB
//
//  Created by Abhishek Shukla on 03/05/25.
//

import Foundation

@Observable
class AuthenticationViewModel {
    
    init() {
        
    }
    
    func login() async throws {
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMTkwM2JlMmI4ODEwNjc4MzVjMzlmYTZmODk5MGE5NSIsIm5iZiI6MTc0NjI2NDE0OC42OTgsInN1YiI6IjY4MTVlMDU0YzM0ZDE4Y2FlYzkxMmU3YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.I3S7yVP4rGi9bmCuUheVvpxa5bpq0_W6_BhqkdiG0yI"
        ]

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
    }
}
