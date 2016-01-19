<%-- 
    Document   : index
    Created on : Feb 10, 2006, 1:50:04 AM
    Author     : Guest
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome To PrognoStore Weather Station</title>

        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/ngStorage/0.3.10/ngStorage.min.js"></script>
        <style>
            table, th , td  {
              border: 1px solid grey;
              border-collapse: collapse;
              padding: 5px;
            }
            table tr:nth-child(odd)	{
              background-color: #f1f1f1;
            }
            table tr:nth-child(even) {
              background-color: #ffffff;
            }
        </style>
    </head>
    <body data-ng-app="weatherStationApp" data-ng-controller="weatherStationCtrl">
        
        <h1>PrognoStore Weather Station</h1>
        
        <div>
            <table border = "1" width = "80%">
                <tr>
                    <td colspan="2"><label style="font-size:20px">Enter your weather information</label></td>
                </tr>                
                <tr>
                    <td><label>Longitude:</label></td><td><input type="text" data-ng-model = "longitude"/></td>
                </tr>
                <tr>
                    <td><label>Latitude:</label></td><td><input type="text" data-ng-model = "latitude"/></td>
                </tr>
                <tr>
                    <td><button data-ng-click="getWeatherInformation()">Get Weather Information</button><td><img id="mySpinner" src="loader.gif" ng-show="loading" /></td></td>
                </tr>
                <tr>
                    <td colspan="2"><em>example longitude = 7 latitude = 9</em></td>
                </tr>
            </table>
        </div>   
        
        <p>
            <p>          
                <div id  = "showStatus">
                </div>

             </p>
             <div id = "showWeatherInformation">
                
                <table border = "1" width = "80%">
                    <tr>
                        <td>Weather Condition</td><td>{{weatherCondition}}</td>
                    </tr> 
                    <tr>
                        <td>Longitude</td><td>{{longitude}}</td>
                    </tr> 
                    <tr>
                        <td>Clouds</td><td>{{latitude}}</td>
                    </tr>                     
                    <tr>
                        <td>Clouds</td><td>{{clouds}}</td>
                    </tr> 
                    <tr>
                        <td>Observation</td><td>{{observation}}</td>
                    </tr>  
                    <tr>
                        <td>Wind Direction</td><td>{{windDirection}}</td>
                    </tr> 
                    <tr>
                        <td>ICAO</td><td>{{ICAO}}</td>
                    </tr> 
                    <tr>
                        <td>Elevation</td><td>{{elevation}}</td>
                    </tr> 
                    <tr>
                        <td>Country Code</td><td>{{countryCode}}</td>
                    </tr> 
                    <tr>
                        <td>Clouds Code</td><td>{{cloudsCode}}</td>
                    </tr>                     
                    <tr>
                        <td>Temperature</td><td>{{temperature}}</td>
                    </tr>       
                    <tr>
                        <td>Dew Point</td><td>{{dewPoint}}</td>
                    </tr> 
                    <tr>
                        <td>Wind Speed</td><td>{{windSpeed}}</td>
                    </tr> 
                    <tr>
                        <td>Humidity</td><td>{{humidity}}</td>
                    </tr>
                    <tr>
                        <td>Station Name</td><td>{{stationName}}</td>
                    </tr> 
                    <tr>
                        <td>Date Time</td><td>{{datetime}}</td>
                    </tr> 
                    <tr>
                        <td>HectoPasc Altimeter</td><td>{{hectoPascAltimeter}}</td>
                    </tr>                 
                </table>

            </div>        
        </p>
        <script>
        
            var app = angular.module('weatherStationApp', ['ngStorage']);
            
            app.controller('weatherStationCtrl', function ($scope, $http, $localStorage) {
                $scope.loading = false;
                
                $scope.getWeatherInformation = function() {
                    $scope.loading = true;
                    $localStorage.username = "prognotest";
                    var geonamesWebService = "http://api.geonames.org/findNearByWeatherJSON?lat="+$scope.latitude+"&"+"lng="+$scope.longitude+"&"+"username="+$localStorage.username;
                    $http.get(geonamesWebService).then(function(response){
                        if(typeof response.data.status !== "undefined"){
                            $localStorage.weatherData = null;// no status message 
                            $scope.updateView($localStorage.weatherData);
                            document.getElementById("showWeatherInformation").style.visibility="hidden"; 
                            document.getElementById("showStatus").innerHTML = "<p style = 'color:red; font-size=23px'>"+"No weather observation"+"</p>";                             
                            $scope.loading = false;
                        }else{
                            $localStorage.weatherData = response.data;// return weather data
                            $scope.updateView($localStorage.weatherData);
                            $scope.loading = false;
                        }
                        
                    },
                    function errorCallback(response) {
                        document.getElementById("showWeatherInformation").style.visibility="hidden"; 
                        document.getElementById("showStatus").innerHTML = "<p style = 'color:red; font-size=23px'>"+response.data.status.message+"</p>"; 
                        $scope.loading = false;
                    });
                     
                };
                
                $scope.updateView = function($weatherData){
                    
                    if(typeof $weatherData !== "undefined" && $weatherData !== null){
                        $scope.weatherCondition = $localStorage.weatherData.weatherObservation.weatherCondition;
                        $scope.clouds = $localStorage.weatherData.weatherObservation.clouds;
                        $scope.observation = $localStorage.weatherData.weatherObservation.observation;
                        $scope.windDirection = $localStorage.weatherData.weatherObservation.windDirection;
                        $scope.ICAO = $localStorage.weatherData.weatherObservation.ICAO;
                        $scope.elevation = $localStorage.weatherData.weatherObservation.elevation;
                        $scope.countryCode = $localStorage.weatherData.weatherObservation.countryCode;
                        $scope.cloudsCode = $localStorage.weatherData.weatherObservation.cloudsCode;
                        $scope.longitude = $localStorage.weatherData.weatherObservation.lng;
                        $scope.latitude = $localStorage.weatherData.weatherObservation.lat; 
                        $scope.temperature = $localStorage.weatherData.weatherObservation.temperature;
                        $scope.dewPoint = $localStorage.weatherData.weatherObservation.dewPoint;
                        $scope.windSpeed = $localStorage.weatherData.weatherObservation.windSpeed;
                        $scope.humidity = $localStorage.weatherData.weatherObservation.humidity;
                        $scope.stationName = $localStorage.weatherData.weatherObservation.stationName;
                        $scope.datetime = $localStorage.weatherData.weatherObservation.datetime;
                        $scope.hectoPascAltimeter = $localStorage.weatherData.weatherObservation.hectoPascAltimeter;
                        document.getElementById("showStatus").innerHTML = "<p style = 'color:blue; font-size=23px'>The information below shows the weather observation where the longitude is "+$scope.longitude+ " and latitude is "+$scope.latitude+"</p>"; 
                        document.getElementById("showWeatherInformation").style.visibility = "visible"; 
                    }else{
                        $scope.weatherCondition = "";
                        $scope.clouds = "";
                        $scope.observation = "";
                        $scope.windDirection = "";
                        $scope.ICAO = "";
                        $scope.elevation = "";
                        $scope.countryCode = "";
                        $scope.cloudsCode = "";
                        $scope.temperature = "";
                        $scope.dewPoint = "";
                        $scope.windSpeed = "";
                        $scope.humidity = "";
                        $scope.stationName = "";
                        $scope.datetime = "";
                        $scope.hectoPascAltimeter = "";
                        document.getElementById("showWeatherInformation").style.visibility = "hidden"; 
                    }
                    
                };
                
                $scope.updateView($localStorage.weatherData);
                
            });            
        </script>
        
    </body>
</html>
