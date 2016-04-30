clc
clear

beta = 5.0;
T = 4.0;

im = rgb2gray(imread('test1-1.bmp'));
in = imnoise(im,'gaussian',0.0,0.05);

x0 = 0:1:255;
y0 = gaussmf(x0,[9.9479 10.1620]);
x1 = 0:1:255;
y1 = gaussmf(x1,[17.0377 126.9969]);
x2 = 0:1:255;
y2 = gaussmf(x2,[9.9045 244.9331]);

%lbl = floor(rand(size(im,1),size(im,2)) * 3);
lbl = zeros(size(im,1),size(im,2));

for i=0:3
    for j=0:3
        start_x = floor(size(lbl,1)*i/4);
        start_y = floor(size(lbl,2)*j/4);

        end_x = floor(size(lbl,1)*(i + 1)/4);
        end_y = floor(size(lbl,2)*(j + 1)/4);
        L{(i * 4 + j) + 1} = lbl(start_x+1:end_x,start_y+1:end_y);
        I{(i * 4 + j) + 1} = in(start_x+1:end_x,start_y+1:end_y);
        M{(i * 4 + j) + 1} = im(start_x+1:end_x,start_y+1:end_y);
    end
end
parfor i=1:16
    L{i}=partEval(L{i},I{i},M{i},beta,T,y0,y1,y2);
end
for i=0:3
    for j=0:3
        start_x = floor(size(lbl,1)*i/4);
        start_y = floor(size(lbl,2)*j/4);

        end_x = floor(size(lbl,1)*(i + 1)/4);
        end_y = floor(size(lbl,2)*(j + 1)/4);
        lbl(start_x+1:end_x,start_y+1:end_y) = L{(i * 4 + j) + 1};
    end
end
right = sum(sum((lbl==floor(im/100))));
success = right/(size(in,1)*size(in,2));
strcat('success:',num2str(success))
pic = uint8(lbl*127);
imshow(pic)
'done'