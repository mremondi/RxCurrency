//
//  GraphView.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/30/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import UIKit

class GraphView: UIView{
    var points: [CGPoint] = []
    var trendLine: [CGPoint] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(points: [CGPoint], trendLine: [CGPoint]) {
        self.points = points
        self.trendLine = trendLine
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        drawAxes()
        plotPoints()
        plotTrendLine()
    }
    
    private func drawAxes(){
        let xAxis = UIBezierPath()
        xAxis.lineWidth = 2
        xAxis.move(to: CGPoint(x: 0.0, y: 0.0))
        xAxis.addLine(to: CGPoint(x: 0.0, y: bounds.maxY))
        UIColor.black.setStroke()
        xAxis.stroke()
        
        let yAxis = UIBezierPath()
        yAxis.lineWidth = 2
        yAxis.move(to: CGPoint(x: 0.0, y: bounds.maxY))
        yAxis.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        UIColor.black.setStroke()
        yAxis.stroke()
    }
    
    private func plotPoints(){
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        let path = UIBezierPath()
        path.lineWidth = 1
        path.move(to: CGPoint(
            x: points[0].x,
            y: points[0].y))
        points.remove(at: 0)
        for point in points{
            path.addLine(to: CGPoint(
                x: point.x * maxX,
                y: maxY - point.y * maxY))
        }
        UIColor.black.setStroke()
        path.stroke()
    }
    
    private func plotTrendLine(){
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        print(trendLine[0].x)
        print(trendLine[0].y)
        print(trendLine[1].x)
        print(trendLine[1].y)
        let path = UIBezierPath()
        path.lineWidth = 1
        path.move(to: CGPoint(x: trendLine[0].x * maxX, y: maxY - trendLine[0].y * maxY))
        path.addLine(to: CGPoint(x: trendLine[1].x * maxX, y: maxY - trendLine[1].y * maxY))
        UIColor.red.setStroke()
        path.stroke()
    }
}
