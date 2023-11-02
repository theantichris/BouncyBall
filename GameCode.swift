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

fileprivate func setUpBarrier() {
    barrier.position = Point(x: 200, y: 150)
    barrier.angle = 0.1
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .brown
    
    scene.add(barrier)
}

fileprivate func setUpFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    funnel.fillColor = .gray
    funnel.isDraggable = false
    funnel.onTapped = dropBall
    
    scene.add(funnel)
}

fileprivate func setUpTarget() {
    target.position = Point(x: 115, y: 447)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.isDraggable = false
    target.fillColor = .yellow
    target.name = "target"
    
    scene.add(target)
}

func setup() {
    setUpBall()
    setUpBarrier()
    setUpFunnel()
    setUpTarget()
    
    scene.onShapeMoved = printPosition(of:)
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    barrier.isDraggable = false
    
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
    barrier.isDraggable = true
}

// Resets the game by moving the ball below the scene which will unlock the barriers.
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

// Prints the position of a shape to the console.
func printPosition(of shape: Shape) {
    print(shape.position)
}
