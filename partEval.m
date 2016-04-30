function [lbl]=partEval(lbl,in,im,beta,T,y0,y1,y2)
    U = Ufunc(lbl,beta,in,im,y0,y1,y2);
    for loop=1:150000
        x = randi([1 size(lbl,1)]);
        y = randi([1 size(lbl,2)]);
        lblt = zeros(size(lbl));
        lblt(:,:) = lbl(:,:);
        lblt(x,y) = mod(lblt(x,y) + ceil(rand()*2),3);

        Ut = Ufunc(lblt,beta,in,im,y0,y1,y2);
        % Ufunc, success
        dU = Ut - U;
        if dU < 0
            lbl=lblt;
            U = Ut;
        else
            p = rand();
            if p < exp(-dU/T)
                lbl=lblt;
                U = Ut;
            end
        end
        T = T * 0.95;
    end