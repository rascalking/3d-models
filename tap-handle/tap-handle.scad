use <libs/threads.scad>

// smoothness of anything rounded
$fn = 100;

// font
font = "Liberation Mono:style=Regular";

// unit conversion
mm_per_inch = 25.4;

// just use globals for now
handle_height = 75; // mm
thread_diameter = 3/8; // in
bottom_handle_diameter = (thread_diameter + 1/3) * mm_per_inch; // mm
top_handle_diameter = bottom_handle_diameter + (1/3 * mm_per_inch); // mm

// label
label_text = "IPA";
label_text_depth = 10; // mm
label_text_height = 8; // mm
label_back_size = [30, 5, 20]; // mm 
label_rounding_radius = 2; // mm
label_back_cube_size = [
    label_back_size[0] - (2*label_rounding_radius),
    label_back_size[1] - (2*label_rounding_radius),
    label_back_size[2] - (2*label_rounding_radius)
]; // mm
label_origin = [0, -top_handle_diameter/2,
                handle_height-(label_back_size[2]/2)]; // mm
                
module write_label(text, height, depth, label_size, label_location, font) {
    // put it where it belongs
    translate(label_location)
        // rotate it to face -Y
        rotate([90,0,0])
            // center along the Z axis
            translate([0, 0, -depth/2])
                // extrude it into 3d
                linear_extrude(height=depth)
                    // resize to fit the label back
                    resize(label_size - [2*(height/10)])
                        // center the text along the y axis
                        translate([0, -height/2])
                            // write the text
                            text(text, font=font, halign="center", size=height);
}


difference() {
    difference() {
        hull() {
            cylinder(h=handle_height,
                     r1=bottom_handle_diameter/2,
                     r2=top_handle_diameter/2);
            translate(label_origin) {
                minkowski() {
                    cube(label_back_cube_size, center=true);
                    sphere(r=2);
                }
            }
        }
        english_thread(diameter=3/8, threads_per_inch=16,
                       length=(handle_height/2)/mm_per_inch, internal=true);
    }
    color("black")
        write_label(text=label_text, height=label_text_height,
                    depth=label_text_depth,
                    label_size=[label_back_cube_size[0], 
                                label_back_cube_size[2]-2],
                    label_location=label_origin,
                    font=font);
}
