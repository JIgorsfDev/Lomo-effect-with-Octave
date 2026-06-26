pkg load image

img = imread("forrest.jpg");

sat = rgb2hsv(img);

s = sat(:,:,2);
s = min(s * 1.2, 1);
sat(:,:,2) = s;

v = sat(:,:,3);
v = histeq(v);
sat(:,:,3) = v;

img_sat = hsv2rgb(sat);

[lines, columns, colors] = size(img_sat);

[x,y] = meshgrid(1:columns,1:lines);

cx = columns/2;
cy = lines/2;

dist = sqrt((x - cx).^2 + (y - cy).^2);
dist = dist / max(dist(:));

mask = cos(dist * pi/2).^0.7;

img_vin = img_sat;

for i = 1:colors
    img_vin(:,:,i) = img_vin(:,:,i) .* mask;
end

subplot(1,3,1);
imshow(img);
title("Original");

subplot(1,3,2);
imshow(img_sat);
title("Saturacao + Contraste");

subplot(1,3,3);
imshow(img_vin);
title("Lomo Final");
