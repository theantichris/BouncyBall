import Foundation

let circle = OvalShape(width: 40, height: 40)

let barrierWidth = 300.0
let barrierHeight = 25.0
let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]
let barrier = PolygonShape(points: barrierPoints)

let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0),
]
let funnel = PolygonShape(points: funnelPoints)

fileprivate func setUpBall() {
    circle.position = Point(x: 250, y: 400)
    circle.hasPhysics = true
    circle.fillColor = .red
    scene.add(circle)
}

fileprivate func setUpBarrier() {
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .brown
    scene.add(barrier)
}

fileprivate func setUpFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    funnel.fillColor = .gray
    funnel.onTapped = dropBall
    scene.add(funnel)
}

func setup() {
    setUpBall()
    setUpBarrier()
    setUpFunnel()
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    circle.position = funnel.position
}
