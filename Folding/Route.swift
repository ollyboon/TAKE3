//
//  Route.swift
//  Folding
//
//  Created by Kyle Goslan on 10/05/2016.
//  Copyright © 2016 Kyle Goslan. All rights reserved.
//

import UIKit
import CoreLocation

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

    
    init(name: String, foldingName: String, duration: String, info: String, terrainInfo: String, terrainImage: String, mapRouteImage: String, color: UIColor, colorDiff: String) {
        self.name = name
        self.foldingName = foldingName
        self.duration = duration
        self.info = info
        self.terrainInfo = terrainInfo
        self.terrainImage = terrainImage
        self.mapRouteImage = mapRouteImage
        self.color = color
        self.colordiff = colorDiff
    }
    
}


func buildRoutes() -> [Route] {
    var routes = [Route]()

    routes.append(Route(name: "Sensory Path",
        foldingName: "Sensory Path",
        duration: "15 Mins",
        info: "Stimulating the senses, taking you through a variety of habitats",
        terrainInfo: "Variable path surface, some grassed areas",
        terrainImage: "terrainImage1",
        mapRouteImage: "mapRouteImage1",
        color: UIColor(redX: 96, greenX: 142, blueX: 230, alphaX: 1),
        colorDiff: "green"
        )
    )
    routes.append(Route(name: "Bird Hide Path",
        foldingName: "Bird Hide Path",
        duration: "5 Mins",
        info: "Take a journey to the Bird hide, an ideal place to view the varied bird species of Holton Lee",
        terrainInfo: "Variable path surface, some wet areas",
        terrainImage: "terrainImage1",
        mapRouteImage: "mapRouteImage2",
        color: UIColor(redX: 189, greenX: 140, blueX: 72, alphaX: 1),
        colorDiff: "green"
        )
    )
    routes.append(Route(name: "The Clump Path",
        foldingName: "The Clump Path",
        duration: "10 Mins",
        info: "Enjoy a walk to the Clump, with stunning views and our impressive weaving tree",
        terrainInfo: "Variable path surface, some dry areas",
        terrainImage: "terrainImage1",
        mapRouteImage: "mapRouteImage3",
        color: UIColor(redX: 225, greenX: 110, blueX: 110, alphaX: 1),
        colorDiff: "orange"
        )
    )
    routes.append(Route(name: "Sea View Path",
        foldingName: "Sea View Path",
        duration: "15 Mins",
        info: "A trail leading you to the sea, with a great vantage point",
        terrainInfo: "Variable path surface, some muddy areas",
        terrainImage: "terrainImage1",
        mapRouteImage: "mapRouteImage4",
        color: UIColor(redX: 216, greenX: 132, blueX: 253, alphaX: 1),
        colorDiff: "orange"
        )
    )
    routes.append(Route(name: "Heathland Path",
        foldingName: "Heathland Path",
        duration: "25 Mins",
        info: "Take a journey through the estate's varied environments",
        terrainInfo: "Variable path surface, some epic areas",
        terrainImage: "terrainImage1",
        mapRouteImage: "mapRouteImage5",
        color: UIColor(redX: 241, greenX: 95, blueX: 140, alphaX: 1),
        colorDiff: "red"
        )
    )
    
    return routes
}

