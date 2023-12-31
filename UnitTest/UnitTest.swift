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
    var weatherServiceMock: WeatherServiceMock!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        weatherServiceMock = WeatherServiceMock()
        sut.weatherService = weatherServiceMock
        sut.weatherService.delegate = sut
        sut.loadViewIfNeeded()
    }

    func testSunnyWeatherDisplaysSunnyImage() {
        weatherServiceMock.weatherResponse = WeatherResponse(weatherCondition: "sunny", minTemperature: 0, maxTemperature: 0, date: "")
        weatherServiceMock.weatherType = .sunny
        weatherServiceMock.fetchWeather()
        XCTAssertEqual(sut.weatherImageView.image, WeatherType.sunny.image)
    }

    func testCloudyWeatherDisplaysCloudyImage() {
        weatherServiceMock.weatherResponse = WeatherResponse(weatherCondition: "cloudy", minTemperature: 0, maxTemperature: 0, date: "")
        weatherServiceMock.weatherType = .cloudy
        weatherServiceMock.fetchWeather()
        XCTAssertEqual(sut.weatherImageView.image, WeatherType.cloudy.image)
    }

    func testRainyWeatherDisplaysRainyImage() {
        weatherServiceMock.weatherResponse = WeatherResponse(weatherCondition: "rainy", minTemperature: 0, maxTemperature: 0, date: "")
        weatherServiceMock.weatherType = .rainy
        weatherServiceMock.fetchWeather()
        XCTAssertEqual(sut.weatherImageView.image, WeatherType.rainy.image)
    }

    func testMaxTemperatureIsDisplayed() {
        let expectedTemperature = 30
        weatherServiceMock.weatherResponse = WeatherResponse(weatherCondition: "sunny", minTemperature: 0, maxTemperature: expectedTemperature, date: "")
        weatherServiceMock.weatherType = .sunny
        weatherServiceMock.fetchWeather()
        XCTAssertEqual(sut.highestTemperature.text, "\(expectedTemperature)")
    }

    func testMinTemperatureIsDisplayed() {
        let expectedTemperature = 20
        weatherServiceMock.weatherResponse = WeatherResponse(weatherCondition: "sunny", minTemperature: expectedTemperature, maxTemperature: 0, date: "")
        weatherServiceMock.weatherType = .sunny
        weatherServiceMock.fetchWeather()
        XCTAssertEqual(sut.lowestTemperature.text, "\(expectedTemperature)")
    }
}


class WeatherServiceTests: XCTestCase {
    var mockService: WeatherServiceMock!
    var mockDelegate: YumemiWeatherMockDelegate!

    override func setUpWithError() throws {
        super.setUp()
        mockDelegate = YumemiWeatherMockDelegate()
        mockService = WeatherServiceMock()
        mockService.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testJsonDecoding() throws {
        mockService.jsonStringToReturn = """
        {
            "weather_condition": "sunny",
            "min_temperature": -5,
            "max_temperature": 10,
            "date": "2023-07-11T14:05:47+09:00"
        }
        """
        mockService.fetchWeather()

        XCTAssertNotNil(mockDelegate.lastWeatherResponse)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.weatherCondition, "sunny")
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.minTemperature, -5)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.maxTemperature, 10)
        XCTAssertEqual(mockDelegate.lastWeatherResponse?.date, "2023-07-11T14:05:47+09:00")
        XCTAssertEqual(mockDelegate.lastWeatherType, .sunny)
    }
}
