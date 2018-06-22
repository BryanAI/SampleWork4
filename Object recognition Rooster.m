Ia=imread('rooster.jpg');
Ib=imread('woods.png');
Ia=rgb2gray(Ia);
Ia=im2double(Ia);
Ib=im2double(Ib);

% Shift one pixel
i=1;
[w,h]=size(Ia);
new_width=w-i;
new_height=h;
Ishifted=zeros(new_width,new_height);
Ishifted(1:new_width,1:new_height)=Ia(i+1:w,i:h);
Ioriginal=zeros(new_width,new_height);
Ioriginal(1:new_width,1:new_height)=Ia(1:new_width,1:new_height);
Correlation=corr2(Ioriginal,Ishifted);
%% correletaion Script
[w,h]=size(Ia);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ia(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ia(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor1(i)=Correlation;
end

[w,h]=size(Ib);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ib(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ib(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor2(i)=Correlation;
end

%% Redundancy Reduction

G1=fspecial('gaussian',[36,36],6);
G2=fspecial('gaussian',[36,36],2);
DoG=G1-G2;

Ia1=conv2(Ia,DoG,'full');
Ib1=conv2(Ib,DoG,'full');

[w,h]=size(Ia1);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ia1(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ia1(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor3(i)=Correlation;
end

[w,h]=size(Ib1);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ib1(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ib1(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor4(i)=Correlation;
end

%% Other gaussians

G1=fspecial('gaussian',[24,24],4);
G2=fspecial('gaussian',[24,24],0.5);
DoG=G1-G2;

Ia1=conv2(Ia,DoG,'full');
Ib1=conv2(Ib,DoG,'full');

[w,h]=size(Ia1);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ia1(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ia1(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor5(i)=Correlation;
end

[w,h]=size(Ib1);
for i=1:30
    new_width=w-i;
    new_height=h;
    Ishifted=zeros(new_width,new_height);
    Ishifted(1:new_width,1:new_height)=Ib1(i+1:w,1:h);
    Ioriginal=zeros(new_width,new_height);
    Ioriginal(1:new_width,1:new_height)=Ib1(1:new_width,1:new_height);
    Correlation=corr2(Ioriginal,Ishifted);
    Cor6(i)=Correlation;
end


%% Mach Bands

Ic=imread('boxes.pgm');
Ic=im2double(Ic);

G1=fspecial('gaussian',[18,18],3);
G2=fspecial('gaussian',[18,18],2);
DoG=G1-G2;

Ic1=conv2(Ic,DoG,'full');
figure(1)
imagesc(Ic1); colorbar
colormap('gray');

%% Simple Cells (at one orientation)
clear;
Ie=imread('elephant.png');
Ie=im2double(Ie);

Gab1=gabor(4,90,8,0,0.5);
Ie1=conv2(Ie,Gab1,'valid');


figure(1)
subplot(1,3,1),imagesc(Ie1); colorbar
colormap('gray');

Gab2=gabor(4,90,8,90,0.5);
Ie2=conv2(Ie,Gab2,'valid');

Ie3=sqrt(Ie1.^2+Ie2.^2);
subplot(1,3,2),imagesc(Ie3); colorbar
colormap('gray');

for i=1:12
    o=(i-1)*15;
    G1=gabor(4,o,8,0,0.5);
    Ie4=conv2(Ie,G1,'valid');
    G2=gabor(4,o,8,90,0.5);
    Ie5=conv2(Ie,G2,'valid');
    Ie6=sqrt(Ie4.^2+Ie5.^2);
    Ic(:,:,i)=Ie6;
end
Ie7=max(Ic,[],3);

subplot(1,3,3), imagesc(Ie7); colorbar
colormap('gray');
