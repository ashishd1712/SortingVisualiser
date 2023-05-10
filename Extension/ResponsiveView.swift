//
//  ResponsiveView.swift
//  SortingVisualiser
//
//  Created by Ashish Dutt on 16/04/23.
//

import SwiftUI

struct ResponsiveView<Content:View>: View {
    var content:(LayoutProperties) -> Content
    var body: some View {
        GeometryReader{geo in
            let height = geo.size.height
            let width = geo.size.width
            let landScape = height<width
            let dimensValues = CustomDimensValues(height:height, width:width)
            let customFontSize = CustomFontSize(height:height, width:width)
            content(
                LayoutProperties(
                    landscape: landScape,
                    dimensValues: dimensValues,
                    customFontSize: customFontSize,
                    height: height,
                    width: width
                )
            )
        }
    }
}

struct CustomFontSize {
    let small:CGFloat
    let smallMedium:CGFloat
    let semiMedium: CGFloat
    let medium:CGFloat
    let mediumLarge:CGFloat
    let large:CGFloat
    let extraLarge:CGFloat
    init(height:CGFloat, width:CGFloat){
        let widthToCalculate = height<width ? height : width
        switch widthToCalculate {
        case _ where widthToCalculate<700:
            small = 8
            smallMedium = 15
            semiMedium = 30
            medium = 40
            mediumLarge = 16
            large = 70
            extraLarge = 60
        case _ where widthToCalculate>=700 && widthToCalculate<1000:
            small = 15
            smallMedium = 18
            semiMedium = 40
            medium = 55
            mediumLarge = 65
            large = 80
            extraLarge = 100
        case _ where widthToCalculate>=1000:
            small = 20
            smallMedium = 20
            semiMedium = 50
            medium = 65
            mediumLarge = 70
            large = 85
            extraLarge = 100
        default:
            small = 8
            smallMedium = 11
            semiMedium = 13
            medium = 14
            mediumLarge = 16
            large = 18
            extraLarge = 25
        }
    }
}

struct CustomDimensValues {
    let small:CGFloat
    let smallMedium:CGFloat
    let medium:CGFloat
    let mediumLarge:CGFloat
    let large:CGFloat
    let extraLarge:CGFloat
    init(height:CGFloat, width:CGFloat){
        let widthToCalculate = height<width ? height : width
        switch widthToCalculate{
        case _ where widthToCalculate<700:
                    small = 7
                    smallMedium = 70
                    medium = 125
                    mediumLarge = 50
                    large = 300
                    extraLarge = 400
                case _ where widthToCalculate>=700 && widthToCalculate<1000:
                    small = 14
                    smallMedium = 80
                    medium = 175
                    mediumLarge = 100
                    large = 400
                    extraLarge = 600
                case _ where widthToCalculate>=1000:
                    small = 17
                    smallMedium = 100
                    medium = 205
                    mediumLarge = 205
                    large = 500
                    extraLarge = 800
                default:
                    small = 5
                    smallMedium = 8
                    medium = 10
                    mediumLarge = 13
                    large = 15
                    extraLarge = 20
        }
    }
}

struct LayoutProperties {
    var landscape:Bool
    var dimensValues:CustomDimensValues
    var customFontSize:CustomFontSize
    var height:CGFloat
    var width:CGFloat
}

func getPreviewLayoutProperties(landscape:Bool, height: CGFloat, width: CGFloat) -> LayoutProperties{
    return LayoutProperties(
        landscape: landscape,
        dimensValues: CustomDimensValues(height: height, width: width),
        customFontSize: CustomFontSize(height: height, width: width),
        height: height,
        width: width
    )
}
