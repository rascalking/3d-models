use <libs/threads.scad>
use <libs/Write.scad>

// TODO - derive text_back_size from text size
// TODO - smooth out text backing corners

// smoothness of circles/spheres
$fn = 100;

// unit conversion
mm_per_inch = 25.4;

// just use globals for now
handle_height = 75; // mm
thread_diameter = 3/8; // in
bottom_handle_diameter = (thread_diameter + 1/2) * mm_per_inch; // mm
top_handle_diameter = bottom_handle_diameter + (1/2 * mm_per_inch); // mm

// label
label_text = "IPA";
label_text_depth = 10; // mm
label_text_height = 8; // mm
label_back_size = [30, 5, 10]; // mm 
label_origin = [0, -top_handle_diameter/2, handle_height-5];

difference() {
    difference() {
        hull() {
            cylinder(h=handle_height,
                     r1=bottom_handle_diameter/2,
                     r2=top_handle_diameter/2);
            translate(label_origin)
                cube(label_back_size, center=true);
        }
        english_thread(diameter=3/8, threads_per_inch=16,
                       length=(handle_height/2)/mm_per_inch, internal=true);
    }
    color("black")
        writecube(text=label_text, where=label_origin, size=label_back_size,
                  t=label_text_depth, h=label_text_height);
}
