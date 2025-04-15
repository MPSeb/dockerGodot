extends Node

func _ready():
    var m = 
    var g = 9.81
    var rope_in_system = 10.0
    var

    var rope_in_system = 10.0
    var anchor_distance = 2.0
    var anchor_height = 8.0

    var y = anchor_heigt + anchor_distance
    var v = 0.0
    var t = 0.0
    var max_v = 0.0

print("Time(s)\tPos(m)\tVel(m/s)\tAccel(m/s²)\tForce(N)")

    while true:
        var rope_force = 0.0
        var drag_force = -drag_coef * v
        var gravity_force = m * g

        var fall_distance = abs(y - anchor_height)

        # Rope only stretches if fall distance > rope length
        if fall_distance > rope_length:
            var stretch = fall_distance - rope_length
            rope_force = -k * stretch * sign(y - anchor_height)

        var net_force = gravity_force + rope_force + drag_force
        var a = net_force / m

        v += a * dt
        y += v * dt
        t += dt
        max_v = max(max_v, abs(v))

        print("%.2f\t%.2f\t%.2f\t%.2f\t%.2f" % [t, y, v, a, net_force])

        # Stop if velocity is low and rope stretched
        if abs(v) < 0.1 and fall_distance > rope_length:
            break

    print("\n--- Fall Summary ---")
    print("Max speed: %.2f m/s" % max_v)

    var impact_force = m * g + k * (fall_distance - rope_length)
    print("Impact force: %.2f N" % impact_force)

    var fall_factor = (fall_above_anchor * 2) / rope_length
    print("Fall factor: %.2f" % fall_factor)

    get_tree().quit()