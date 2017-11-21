clear all;close all;clc;
run('resultadosr.m');
for i=1:20
imagen=zeros(640,480,320,60);imagen(:,:,1,i)=uint8(r(:,:,i).*16);
end;
implay(imagen,0.5);
