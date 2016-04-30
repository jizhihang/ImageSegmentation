clc
clear
im = imread('test1.bmp');
%in = imnoise(im,'gaussian');
%imwrite(in,'img1_noise.bmp');
in = imread('img1_noise.bmp');
im = rgb2gray(im);
in = rgb2gray(in);
im = double(im);
in = double(in);
index0 = im==0;
index127 = im==127;
index255 = im==255;
xx = in(index0);
avg0 = sum(xx)/sum(sum(index0));
var0 = std(xx);
xx = in(index127);
avg1 = sum(xx)/sum(sum(index127));
var1 = std(xx);
xx = in(index255);
avg2 = sum(xx)/sum(sum(index255));
var2 = std(xx);

x0 = 0:1:255;
y0 = gaussmf(x0,[var0 avg0]);
plot(x0,y0)
xlabel('class0 - gaussian distribution')
figure();

x1 = 0:1:255;
y1 = gaussmf(x1,[var1 avg1]);
plot(x1,y1)
xlabel('class1 - gaussian distribution')
figure();

x2 = 0:1:255;
y2 = gaussmf(x2,[var2 avg2]);
plot(x2,y2)
xlabel('class2 - gaussian distribution')

o=zeros(417,415,3);
right = 0;
for i=1:417
    for j=1:415
        p0 = y0(round(in(i,j)) + 1);
        p1 = y1(round(in(i,j)) + 1);
        p2 = y2(round(in(i,j)) + 1);
        mm = max(p0,max(p1,p2));
        if mm == p0
            o(i,j,:) = [255 0 0];
            if im(i,j) == 0
                right = right +1 ;
            end
        elseif mm == p1
            o(i,j,:) = [0 255 0];
            if im(i,j) == 127
                right = right +1 ;
            end
        else
            o(i,j,:) = [0 0 255];
            if im(i,j) == 255
                right = right +1 ;
            end
        end
    end
end
figure();
imshow(o);
success = right/(417*415);
success
