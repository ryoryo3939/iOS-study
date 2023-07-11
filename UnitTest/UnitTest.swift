//
//  UnitTest.swift
//  UnitTest
//
//  Created by S892 on 2023/07/11.
//

import XCTest
@testable import iOS_study

class WeatherViewControllerTests: XCTestCase {
    var sut: WeatherViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
            sut.loadViewIfNeeded()
    }
        
    func testSunnyWeatherDisplaysSunnyImage() {
        sut.didUpdateWeather(sut.weatherService, weatherResponse: WeatherResponse(weatherCondition: "sunny", minTemperature: 0, maxTemperature: 0, date: ""), weatherType: .sunny)
            
        XCTAssertEqual(sut.weatherImageView.image, UIImage(named: "sunny"))
    }
        
    func testCloudyWeatherDisplaysCloudyImage() {
        sut.didUpdateWeather(sut.weatherService, weatherResponse: WeatherResponse(weatherCondition: "cloudy", minTemperature: 0, maxTemperature: 0, date: ""), weatherType: .cloudy)
            
        XCTAssertEqual(sut.weatherImageView.image, UIImage(named: "cloudy"))
    }
        
    func testRainyWeatherDisplaysRainyImage() {
        sut.didUpdateWeather(sut.weatherService, weatherResponse: WeatherResponse(weatherCondition: "rainy", minTemperature: 0, maxTemperature: 0, date: ""), weatherType: .rainy)
            
        XCTAssertEqual(sut.weatherImageView.image, UIImage(named: "rainy"))
    }
        
    func testMaxTemperatureIsDisplayed() {
        let expectedTemperature = 30
        sut.didUpdateWeather(sut.weatherService, weatherResponse: WeatherResponse(weatherCondition: "sunny", minTemperature: 0, maxTemperature: expectedTemperature, date: ""), weatherType: .sunny)
            
        XCTAssertEqual(sut.highestTemperature.text, "\(expectedTemperature)")
    }
        
    func testMinTemperatureIsDisplayed() {
        let expectedTemperature = 20
        sut.didUpdateWeather(sut.weatherService, weatherResponse: WeatherResponse(weatherCondition: "sunny", minTemperature: expectedTemperature, maxTemperature: 0, date: ""), weatherType: .sunny)
            
        XCTAssertEqual(sut.lowestTemperature.text, "\(expectedTemperature)")
    }
}

class WeatherServiceTests: XCTestCase {
    var sut: WeatherService!
    var mockFetcher: YumemiWeatherMock!
    var mockDelegate: YumemiWeatherMockDelegate!

    override func setUpWithError() throws {
        super.setUp()
        mockFetcher = YumemiWeatherMock()
        mockDelegate = YumemiWeatherMockDelegate()
        sut = WeatherService()
        sut.weatherFetcher = mockFetcher
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockFetcher = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testJsonDecoding() throws {
        // Given
        mockFetcher.jsonStringToReturn = """
        {
            "max_temp": 10,
            "min_temp": -5,
            "date": "2023-07-11T14:05:47+09:00",
            "weather": "sunny"
        }
        """

        // When
        sut.fetchWeather()

        // Then
        XCTAssertNotNil(mockDelegate.lastWeatherResponse)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.weatherCondition, "sunny")
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.minTemperature, -5)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.maxTemperature, 10)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.date, "2023-07-11T14:05:47+09:00")
        XCTAssertEqual(mockDelegate.lastWeatherType, .sunny)
    }
}
