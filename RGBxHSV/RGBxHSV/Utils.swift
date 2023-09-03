//
//  Utils.swift
//  RGBxHSV
//
//  Created by Shinichi Hosomi on 2023/09/03.
//

import Foundation

struct HSVColor {
    var H:Float // [0, 360]
    var S:Float // [0, 100]
    var V:Float // [0, 100]
}

struct RGBColor {
    var R:Float // [0, 255]
    var G:Float // [0, 255]
    var B:Float // [0, 255]
}

func RGB2HSV(rgb: RGBColor) -> HSVColor{
    let R = rgb.R / 255.0
    let G = rgb.G / 255.0
    let B = rgb.B / 255.0
         
    let maxV = max(R, G, B)
    let minV = min(R, G, B)

    let V = maxV

    var S:Float = 0.0
    let diffV = maxV - minV
    // to avoid overflow when maxv is too small
    if(maxV > 0.001) {
        S = diffV / maxV
    }

    var H:Float = 0.0
    
    // to avoid overflow
    if(diffV > 0.001) {
         if(R == maxV) {
             H = 60.0 * (G-B) / diffV
         }
         else if(G == maxV) {
             H = 120.0 + 60.0 * (B-R) / diffV
         }
         else if(B == maxV) {
             H = 240.0 + 60.0 * (R-G) / diffV
         }
    }

    if(H > 360.0) {
         H -= 360
    }
     else if(H < 0.0) {
         H += 360
    }

    let hsv = HSVColor(H: H,S: S * 100,V: V * 100)
    
    return hsv
 }

func HSV2RGB(hsv: HSVColor) -> RGBColor{
    var R:Float = 0.0
    var G:Float = 0.0
    var B:Float = 0.0

    var H:Float = hsv.H
    var S:Float = hsv.S * 0.01
    var V:Float = hsv.V * 0.01

    S = min(1.0, max(0.0, S))
    V = min(1.0, max(0.0, V))

    if (S <= 0.001) {
        R = V
        G = V
        B = V
    }
    else {
        if(H < 60.0) {
             R = V
             G = V * (1.0 + S * ( H / 60.0 - 1.0 ))
             B = V * (1.0 - S)
        }
        else if(H < 120.0) {
             R = V * (1.0 - S * ( (H - 120.0) / 60.0 + 1.0 ))
             G = V
             B = V * (1.0 - S)
        }
        else if(H < 180.0) {
             R = V * (1.0 - S)
             G = V
             B = V * (1.0 + S * ( (H - 120.0) / 60.0 - 1.0 ))
         }
         else if(H < 240.0) {
             R = V * (1.0 - S)
             G = V * (1.0 - S * ( (H - 240.0) / 60.0 + 1.0 ))
             B = V
         }
         else if(H < 300.0) {
             R = V * (1.0 + S * ( (H - 240.0) / 60.0 - 1.0 ))
             G = V * (1.0 - S)
             B = V
         }
         else if(H <= 360.0) {
             R = V
             G = V * (1.0 - S)
             B = V * (1.0 - S * ( (H - 360.0) / 60.0 + 1.0 ))
         }
     }

    let rgb = RGBColor(R: R * 255.0,G: G * 255.0,B: B * 255.0)
    
    return rgb
 }

