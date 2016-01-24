module heart(circle_radius=10) {
    offset = sqrt(pow(circle_radius, 2) * 2) / 2;
    rotate(45) square(circle_radius * 2, center=true);
    translate([offset, offset, 0])
        circle(r=circle_radius);
    translate([-offset, offset, 0])
        circle(r=circle_radius);
}

minkowski() {
    linear_extrude(10) {
        heart(15);
    }
    sphere(r=7.5, $fn=10);
}