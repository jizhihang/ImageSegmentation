clc
clear
im = rgb2gray(imread('test1.bmp'));

in = double(zeros(5,417,415));
in(1,:,:) = imnoise(im,'gaussian',0,0.01);
in(2,:,:) = imnoise(im,'gaussian',0,0.02);
in(3,:,:) = imnoise(im,'gaussian',0,0.03);
in(4,:,:) = imnoise(im,'gaussian',0,0.04);
in(5,:,:) = imnoise(im,'gaussian',0,0.05);

imshow(squeeze(in(1,:,:)));

x0 = 0:1:255;
y0 = gaussmf(x0,[9.9479 10.1620]);
x1 = 0:1:255;
y1 = gaussmf(x1,[17.0377 126.9969]);
x2 = 0:1:255;
y2 = gaussmf(x2,[9.9045 244.9331]);
for k=1:5
    o=zeros(417,415,3);
    right = 0;
    for i=1:417
        for j=1:415
            p0 = y0(round(in(k,i,j)) + 1);
            p1 = y1(round(in(k,i,j)) + 1);
            p2 = y2(round(in(k,i,j)) + 1);
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
end

