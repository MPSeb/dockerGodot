extends Node

func _ready():
    var m = 70.0
    var g = 9.81
    var k = 800.0
    var d = 15.0
    var dt = 0.01

    var y = 3.0
    var v = 0.0
    var t = 0.0
    var max_v = 0.0
    var rope_len = 10.0
    var anchor = 0.0

    print("Time\tPos\tVel\tAcc\tForce")

    while true:
        var fall_dist = abs(y - anchor)
        var stretch = max(fall_dist - rope_len, 0.0)
        var rope_force = -k * stretch * sign(y - anchor)
        var drag = -d * v
        var net_force = m * g + rope_force + drag
        var a = net_force / m

        v += a * dt
        y += v * dt
        t += dt
        max_v = max(max_v, abs(v))

        print("%.2f\t%.2f\t%.2f\t%.2f\t%.2f" % [t, y, v, a, net_force])

        if abs(v) < 0.1 and stretch > 0:
            break

    print("\n--- Fall Summary ---")
    print("Max speed: %.2f m/s" % max_v)
    print("Impact force: %.2f N" % (m * g + k * (fall_dist - rope_len)))
    print("Fall factor: %.2f" % ((y - anchor) * 2 / rope_len))

    get_tree().quit()
