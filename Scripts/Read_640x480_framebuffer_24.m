% Note that framebuffer color values here range from (0 to 255) integer
% so we need to use "uint8" function

% raster area is 640x480 - 24-bit color
% Load memory content into Frame buffer and view the resulting image

clear; clc;
% initialize framebuffer dimensions 
fb_width = 640;
fb_height = 480;
fb_size = fb_width*fb_height;

% reading red channel file
FB_red_in = load('col_buff_r.txt');

% reading green channel file
FB_green_in = load('col_buff_g.txt');

% reading blue channel file
FB_blue_in = load('col_buff_b.txt');

% reading Frame buffer addresses
FB_addr = load('col_buff_addr.txt');

% creating the frame buffer channels
FB_red = zeros(fb_size,1);
FB_green = zeros(fb_size,1);
FB_blue = zeros(fb_size,1);

% filling FB with data
for i=1:length(FB_red_in)
    FB_red(FB_addr(i)+1) = FB_red_in(i);
    FB_green(FB_addr(i)+1) = FB_green_in(i);
    FB_blue(FB_addr(i)+1) = FB_blue_in(i);
end

% creating 2D frame buffer
Frame_buffer = zeros(fb_height,fb_width,3);

i = 1;
for j=1:fb_height
    for k=1:fb_width 
        Frame_buffer(j, k, 1) = FB_red(i);
        Frame_buffer(j, k, 2) = FB_green(i);
        Frame_buffer(j, k, 3) = FB_blue(i);
        i = i + 1;
    end
end

figure(12124)
imshow(uint8(Frame_buffer))
