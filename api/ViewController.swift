//
//  ViewController.swift
//  api
//
//  Created by 古賀遥貴 on 2022/07/10.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.sunrise-sunset.org/json?date=2020-01-01&1at=-74.0060&lng=40.7128&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            // make sure having data
            guard let data = data, error == nil else {
                print("couldn't have data")
                return
            }
            
            // convert data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert: \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
        }
        
        task.resume()
        
    }
}


struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}


//{"results":{"sunrise":"2020-01-01T03:15:37+00:00","sunset":"2020-01-01T15:25:13+00:00","solar_noon":"2020-01-01T09:20:25+00:00","day_length":43776,"civil_twilight_begin":"2020-01-01T02:54:20+00:00","civil_twilight_end":"2020-01-01T15:46:30+00:00","nautical_twilight_begin":"2020-01-01T02:28:11+00:00","nautical_twilight_end":"2020-01-01T16:12:38+00:00","astronomical_twilight_begin":"2020-01-01T02:01:56+00:00","astronomical_twilight_end":"2020-01-01T16:38:54+00:00"},"status":"OK"}
