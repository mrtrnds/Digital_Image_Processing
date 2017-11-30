function [ bw ] = Canny(A,mask,sigma,T1,T2,dimension)
h1= fspecial('gaussian',[dimension dimension],sigma);
B=imfilter(A,h1);
h2=fspecial(mask);
B1=double(imfilter(B,h2));
B2=double(imfilter(B,h2'));
Es=sqrt(B1.^2+B2.^2);
[a,b]=size(B1);
E0=zeros([a b]);
for i=1:a
      for j=1:b
            if(B1(i,j)==0)
               E0(i,j)=atan(B2(i,j)/0.000000000001);
            else
                E0(i,j)=atan(B2(i,j)/B1(i,j));
            end
      end
 end
  E0=E0*(180/3.14);
  for i=1:a
      for j=1:b
            if(E0(i,j)<0)
               E0(i,j)= E0(i,j)-90;
            E0(i,j)=abs(E0(i,j));
            end
      end
 end
  for i=1:a
      for j=1:b
          if ((0<E0(i,j))&&(E0(i,j)<22.5))||((157.5<E0(i,j))&&(E0(i,j)<181))
                E0(i,j)=0;
          elseif (22.5<E0(i,j))&&(E0(i,j)<67.5)
                 E0(i,j)=45;
          elseif (67.5<E0(i,j))&&(E0(i,j)<112.5)  
                  E0(i,j)=90;
          elseif (112.5<E0(i,j))&&(E0(i,j)<157.5)
                  E0(i,j)=135;
          end
      end
  end
  
 
Es = padarray(Es, [1 1]);
for i=2:a-2
    for j=2:b-2
        
          if (E0(i,j)==135)
                 if (Es(i-1,j+1)+Es(i-1,j))/2>Es(i,j)||(Es(i+1,j-1)+Es(i+1,j))/2>Es(i,j)
                      Es(i,j)=0;
                  end
           elseif (E0(i,j)==45)   
                  if (Es(i+1,j+1)+Es(i+1,j))/2>Es(i,j)||(Es(i-1,j-1)+Es(i-1,j))/2>Es(i,j)
                       Es(i,j)=0;
                  end

           elseif (E0(i,j)==90)   
                  if ((Es(i,j+1)>Es(i,j))||(Es(i,j-1)>Es(i,j)))
                      Es(i,j)=0;
                  end
           elseif (E0(i,j)==0)   
                  if ((Es(i+1,j)>Es(i,j))||(Es(i-1,j)>Es(i,j)))
                      Es(i,j)=0;
                  end
           end
    end
end

aboveT1 = Es > T1;                     
                                           
[aboveT2r, aboveT2c] = find(Es > T2);  
bw = bwselect(aboveT1, aboveT2c, aboveT2r, 8);


end

