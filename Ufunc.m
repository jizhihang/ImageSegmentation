function res = Ufunc (lbl,beta,image,im,y0,y1,y2)
    lbl0= lbl==0;
    lbl1= lbl==1;
    lbl2= lbl==2;

    p0=y0(image(lbl0)+1);
    p1=y1(image(lbl1)+1);
    p2=y2(image(lbl2)+1);
    
    part1=sum(log(p0))+sum(log(p1))+sum(log(p2));

    lblr = zeros(size(lbl));
    lblr(2:size(lbl,1),:)=lbl(1:size(lbl,1)-1,:);
    part2 = (((lblr==lbl) * -2) + 1) * beta;

%    lblru = zeros(size(lbl));
%    lblru(2:size(lbl,1),2:size(lbl,2))=lbl(1:size(lbl,1)-1,1:size(lbl,2)-1);
%    part2 = (((lblru==lbl) * -2) + 1) * beta;

    lbll = zeros(size(lbl));
    lbll(1:size(lbl,1)-1,:)=lbl(2:size(lbl,1),:);
    part2 = part2 + (((lbll==lbl) * -2) + 1) * beta;

%    lbllu = zeros(size(lbl));
%    lbllu(1:size(lbl,1)-1,2:size(lbl,2))=lbl(2:size(lbl,1),1:size(lbl,2)-1);
%    part2 = (((lbllu==lbl) * -2) + 1) * beta;

    lblu = zeros(size(lbl));
    lblu(:,2:size(lbl,2))=lbl(:,1:size(lbl,2)-1);
    part2 = part2 + (((lblu==lbl) * -2) + 1) * beta;

    lbld = zeros(size(lbl));
    lbld(:,1:size(lbl,2)-1)=lbl(:,2:size(lbl,2));
    part2 = part2 + (((lbld==lbl) * -2) + 1) * beta;

%    lblrd = zeros(size(lbl));
%    lblrd(2:size(lbl,1),1:size(lbl,2)-1)=lbl(1:size(lbl,1)-1,2:size(lbl,2));
%    part2 = (((lblrd==lbl) * -2) + 1) * beta;

%    lblld = zeros(size(lbl));
%    lblld(1:size(lbl,1)-1,1:size(lbl,2)-1)=lbl(2:size(lbl,1),2:size(lbl,2));
%    part2 = (((lblld==lbl) * -2) + 1) * beta;

    res = -part1 + sum(sum(part2)); 
