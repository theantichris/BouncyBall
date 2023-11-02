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

func setup() {
    // Add a circle to the scene.
    circle.position = Point(x: 250, y: 400)
    circle.hasPhysics = true
    circle.fillColor = .red
    scene.add(circle)
    
    // Add a barrer to the scene.
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .brown
    scene.add(barrier)
    
    // Add a funnel to the scene.
    funnel.position = Point(x: 200, y: scene.height - 25)
    funnel.fillColor = .gray
    scene.add(funnel)
    
    funnel.onTapped = dropBall
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    circle.position = funnel.position
}
