//
//  ViewController.swift
//  WeatherApp
//
//  Created by Shubhangi Biradar on 2023-07-28.
//

import UIKit
import CoreLocation

var searchedCityName: String?
var temp: Double = 0.0
var cityTemp: String = "London"
var icon: String = "Link"
var networkModel = NetworkModel()
var tempC: String?
var tempF: String?
var city: String? = nil

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
   // let locationDelegate = MyLocationDelegate()

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
   
    @IBOutlet weak var cityListBtn: UIButton!
    
    @IBAction func cityBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCityList", sender: self)
        
    }
    
    @IBAction func searchCityBtn(_ sender: Any) {
        searchedCityName = searchField.text
        
        if let searchedCityName = searchedCityName{
            print(searchedCityName)
            fetchWeatherData(for: searchedCityName)
            searchField.text = ""
            loadData()
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
        fetchWeatherData(for:"Toronto")
           
    }
    
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    @IBAction func tempFahrenheit(_ sender: UIButton) {
        temperatureLabel.text = tempF
    }
    
    @IBAction func tempCelsius(_ sender: UIButton) {
        temperatureLabel.text = tempC
    }
    
    func fetchWeatherData(for city: String) {
        networkModel.searchWeather(for: city) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.updateData(with: weatherData)
            }
        }
    }
    
    private func updateData(with weatherData: Weather) {
        temp = (weatherData.current.tempCelsius)
        cityNameLabel.text = "\(weatherData.location.cityName)"
        temperatureLabel.text = "\(weatherData.current.tempCelsius) °C"
        
        tempF = "\(weatherData.current.tempFahrenheit) °F"
        tempC = "\(weatherData.current.tempCelsius) °C"
        print(weatherData.current.condition.code)
        
        switch (weatherData.current.condition.code){
            
        case 1000:
            weatherConditionLabel.text = "Sunny"
        
        case 1003:
            weatherConditionLabel.text = "Partly cloudy"
            
        case 1006:
            weatherConditionLabel.text = "Cloudy"
            
        case 1009:
            weatherConditionLabel.text = "Overcast"
            
        case 1030:
            weatherConditionLabel.text = "Mist"
            
        case 1063:
            weatherConditionLabel.text = "Patchy rain possible"
            
        case 1066:
            weatherConditionLabel.text = "Patchy snow possible"
            
        case 1069:
            weatherConditionLabel.text = "Patchy sleet possible"
            
        case 1072:
            weatherConditionLabel.text = "Patchy freezing drizzle possible"
            
        case 1087:
            weatherConditionLabel.text = "Thundery outbreaks possible"
            
        case 1114:
            weatherConditionLabel.text = "Blowing snow"
            
        case 1117:
            weatherConditionLabel.text = "Blizzard"
            
        case 1135:
            weatherConditionLabel.text = "Fog"
            
        case 1147:
            weatherConditionLabel.text = "Freezing fogny"
            
        case 1150:
            weatherConditionLabel.text = "Patchy light drizzle"
            
        case 1153:
            weatherConditionLabel.text = "Light drizzle"
            
        case 1168:
            weatherConditionLabel.text = "Freezing drizzle"
            
        case 1171:
            weatherConditionLabel.text = "Heavy freezing drizzle"
            
        case 1180:
            weatherConditionLabel.text = "Patchy light rain"
            
        case 1183:
            weatherConditionLabel.text = "Light rain"
            
        case 1186:
            weatherConditionLabel.text = "Moderate rain at times"
            
        case 1189:
            weatherConditionLabel.text = "Moderate rain"
            
        default:
            weatherConditionLabel.text = "No data available"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("Got location")
        if let location = locations.last {
            print("Latitude: \(location.coordinate.latitude)")
            print("Longitude: \(location.coordinate.longitude)")
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print(error)
                }
                if let placemark = placemarks?.first {
                    city = placemark.locality!
                    print("City: \(city ?? "London,On")")
                    self.fetchWeatherData(for: (city ?? "London,On"))
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}


//class MyLocationDelegate: NSObject, CLLocationManagerDelegate {
//
//    //var classViewCont = ViewController()
//
//
//}
