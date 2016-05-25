//
//  myLocation.swift
//  Folding
//
//  Created by Hallam John Ager on 22/05/2016.
//  Copyright © 2016 Hallam John Ager. All rights reserved.
//

import UIKit
import CoreLocation

//This file is a custom class for the each of the routes. It contains all the info for the routes to be displayed on the screen and in the table cells. 

class Route {
    
    let name: String!
    let foldingName: String!
    let duration: String!
    let info: String!
    let terrainInfo: String!
    let terrainImage: String!
    let mapRouteImage: String!
    let color: UIColor!
    let colordiff: String!
    let terrainType: String!

    
    init(name: String, foldingName: String, duration: String, info: String, terrainInfo: String, terrainImage: String, mapRouteImage: String, color: UIColor, colorDiff: String, terrainType: String) {
        
        self.name = name
        self.foldingName = foldingName
        self.duration = duration
        self.info = info
        self.terrainInfo = terrainInfo
        self.terrainImage = terrainImage
        self.mapRouteImage = mapRouteImage
        self.color = color
        self.colordiff = colorDiff
        self.terrainType = terrainType
    }
    
}


func buildRoutes() -> [Route] {
    var routes = [Route]()
    
    routes.append(Route(name: "Heathland Path",
        foldingName: "Heathland Path",
        duration: "25 minutes",
        info: "Take a journey through the estate's varied environments",
        terrainInfo: "Difficult path surface with some makeshift paths, mix of wet and dry heathland",
        terrainImage: "heathlandterrain@2",
        mapRouteImage: "mapRouteImage5",
        color: UIColor(redX: 241, greenX: 95, blueX: 140, alphaX: 1),
        colorDiff: "red",
        terrainType: "Undulating Terrain"
        )
    )

    routes.append(Route(name: "Sensory Path",
        foldingName: "Sensory Path",
        duration: "15 minutes",
        info: "Stimulating the senses, taking you through a variety of habitats.",
        terrainInfo: "Well made paths surface with easy accessibility.",
        terrainImage: "sensoryterrain@2",
        mapRouteImage: "mapRouteImage1",
        color: UIColor(redX: 96, greenX: 142, blueX: 230, alphaX: 1),
        colorDiff: "green",
        terrainType: "Flat Terrain"
        )
    )
    routes.append(Route(name: "Bird Hide Path",
        foldingName: "Bird Hide Path",
        duration: "5 minutes",
        info: "Take a journey to the Bird hide, an ideal place to view the varied bird species of Holton Lee.",
        terrainInfo: "Easy accessibility from reception with road forming onto gravel paths.",
        terrainImage: "birdhideterrain@2",
        mapRouteImage: "mapRouteImage2",
        color: UIColor(redX: 225, greenX: 229, blueX: 90, alphaX: 1),
        colorDiff: "green",
        terrainType: "Flat Terrain"

        )
    )
    routes.append(Route(name: "The Clump Path",
        foldingName: "The Clump Path",
        duration: "10 minutes",
        info: "Enjoy a walk to the Clump, with stunning views and our impressive weaving tree.",
        terrainInfo: "Variable path surface, easy terrain at start but harder to navigate hills later in the path.",
        terrainImage: "clumpterrain@2",
        mapRouteImage: "mapRouteImage3",
        color: UIColor(redX: 225, greenX: 110, blueX: 110, alphaX: 1),
        colorDiff: "orange",
        terrainType: "Undulating Terrain"
        )
    )
    routes.append(Route(name: "Sea View Path",
        foldingName: "Sea View Path",
        duration: "15 minutes",
        info: "A trail leading you to the sea, with a great vantage point",
        terrainInfo: "Grassy surface, making wheelchair accessability hard.",
        terrainImage: "seaviewterrain@2",
        mapRouteImage: "mapRouteImage4",
        color: UIColor(redX: 216, greenX: 132, blueX: 253, alphaX: 1),
        colorDiff: "orange",
        terrainType: "Undulating Terrain"
        )
    )

    
    return routes
}

