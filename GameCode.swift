import Foundation

let ball = OvalShape(width: 40, height: 40)

var barriers: [Shape] = []
var targets: [Shape] = []

let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0),
]
let funnel = PolygonShape(points: funnelPoints)

fileprivate func setUpBall() {
    ball.position = Point(x: 250, y: 400)
    ball.bounciness = 0.6
    ball.hasPhysics = true
    ball.isDraggable = false
    ball.fillColor = .red
    ball.onCollision = ballCollided(with:)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    
    scene.add(ball)
    scene.trackShape(ball)
}

fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    
    let barrier = PolygonShape(points: barrierPoints)
    barrier.position = position
    barrier.angle = angle
    barrier.fillColor = .brown
    barrier.hasPhysics = true
    barrier.isImmobile = true
    
    barriers.append(barrier)
    
    scene.add(barrier)
}

fileprivate func setUpFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    funnel.fillColor = .gray
    funnel.isDraggable = false
    funnel.onTapped = dropBall
    
    scene.add(funnel)
}

fileprivate func addTarget(at position: Point) {
    let targetPoints = [
        Point(x: 10, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y:10),
    ]
    
    let target = PolygonShape(points: targetPoints)
    target.position = position
    target.fillColor = .yellow
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.isDraggable = false
    target.name = "target"
    
    targets.append(target)
        
    scene.add(target)
}

func setup() {
    setUpBall()
    setUpFunnel()
    
    addBarrier(at: Point(x: 175, y: 100), width: 80, height: 25, angle: 0.1)
    addBarrier(at: Point(x: 100, y: 150), width: 30, height: 15, angle: -0.2)
    addBarrier(at: Point(x: 325, y: 150), width: 100, height: 25, angle: 0.3)
    
    addTarget(at: Point(x: 184, y: 563))
    addTarget(at: Point(x: 238, y: 624))
    addTarget(at: Point(x: 269, y: 453))
    addTarget(at: Point(x: 213, y: 348))
    addTarget(at: Point(x: 113, y: 267))
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    for barrier in barriers {
        barrier.isDraggable = false
    }
        
    ball.position = funnel.position
    ball.stopAllMotion()
}

// Handles collisions between the ball and the targets.
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    
    otherShape.fillColor = .green
}

// Unlocks the barriers once the ball is out of play.
func ballExitedScene() {
    for barrier in barriers {
        barrier.isDraggable = true
    }
}

// Resets the game by moving the ball below the scene which will unlock the barriers.
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

// Prints the position of a shape to the console.
func printPosition(of shape: Shape) {
    print(shape.position)
}
