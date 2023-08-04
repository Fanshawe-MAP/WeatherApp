//
//  ViewController.swift
//  WeatherApp
//
//  Created by Shubhangi Biradar on 2023-07-28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private var networkModel = NetworkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchWeatherData(for: "London,On")
    }

    private func fetchWeatherData(for city: String) {
        networkModel.searchWeather(for: city) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.updateUI(with: weatherData)
            }
        }
    }
    
    private func updateUI(with weatherData: Weather) {
        cityNameLabel.text = "\(weatherData.location.cityName)"
        temperatureLabel.text = "\(weatherData.current.tempCelsius) °C"
        print(weatherData.current.condition.code)
    }


}

