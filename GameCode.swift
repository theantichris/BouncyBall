import Foundation

let ball = OvalShape(width: 40, height: 40)

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

let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y:10),
]
let target = PolygonShape(points: targetPoints)

fileprivate func setUpBall() {
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.fillColor = .red
    scene.add(ball)
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

fileprivate func setUpTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .yellow
    
    scene.add(target)
}

func setup() {
    setUpBall()
    setUpBarrier()
    setUpFunnel()
    setUpTarget()
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    ball.position = funnel.position
}
