function [ B,hist1,hist2 ] = SimpleHisteq2(A)
 
% a=size(size(A));
% if a(2)>2
%     handles.A=rgb2gray(handles.im_original);
% end
hist2=zeros(256,1);
[x,y]=size(A);
for i=1:x
    for j=1:y
        pos=A(i,j)+1;
        hist2(pos)=hist2(pos)+1;
    end;
end;
cdf=zeros(256,1);
[x,y]=size(A);
B=zeros(x,y);
for i=1:x
    for j=1:y
        pos=A(i,j)+1;
        cdf(pos)=cdf(pos)+1;
    end
end
cdf=cdf/(x*y);
for i=2:256
    cdf(i)= cdf(i)+cdf(i-1);
end


for i=1:x
    for j=1:y
       B(i,j)=cdf(A(i,j)+1);
    end
end
hist1=zeros(256,1);
B=B*255;
for i=1:x
    for j=1:y
        pos=round(B(i,j))+1;
        hist1(pos)=hist1(pos)+1;
    end
end
B=uint8(B);
%Ax = findall(0,'type','axes');
%axis(Ax(1),[1 256 0 round(max(hist)/2)]); 





