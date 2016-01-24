use <libs/threads.scad>
use <libs/Write.scad>

// TODO - derive text_back_w from text size

// smoothness of anything rounded
$fn = 100;

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
        writecube(text=label_text, where=label_origin, size=label_back_size,
                  t=label_text_depth, h=label_text_height);
}
