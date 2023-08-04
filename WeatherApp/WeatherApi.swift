//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Khyati Vyas on 2023-08-04.
//

import Foundation

struct Weather: Decodable {
    let location: Location
    let current: CurrentWeather
    
}

struct Location: Decodable {
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)
    }
}

struct CurrentWeather: Decodable {
    let tempCelsius: Double
    let tempFahrenheit: Double
    let condition: CurrentCondition
    
    enum CodingKeys: String, CodingKey {
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case condition = "condition"
    }
}

struct CurrentCondition: Decodable{
    let code: Int
    
    enum CodingKeys: String, CodingKey{
        case code = "code"
    }
}

class NetworkModel{
    
    func searchWeather(for city: String, completion: @escaping (Weather) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=7e62e44b6cb4482a931192449232807&q=\(city)"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let weatherData = try decoder.decode(Weather.self, from: data)
                        completion(weatherData)
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}
