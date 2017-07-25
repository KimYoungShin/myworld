function [ out ] = read_drone( arduino )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

receiveData=fread(arduino,12);
str1=receiveData(1:6);
stop1=NaN;
stop2=NaN;
stop3=NaN;
stop4=NaN;
stop5=NaN;
stop6=NaN;
stop7=NaN;

for j=7:length(receiveData)%to find the end of the first number sent
    if (receiveData(j-6) >  50 && receiveData(j-5) == 255 && receiveData(j-4) == 10 && receiveData(j-3) == 85 && receiveData(j-2)==80 && receiveData(j-1)==18 )
        stop1=j;
        stop2=j+1;
        stop3=j+2;
        stop4=j+3;
        stop5=j+4;
        stop6=j+5;
        stop7=j+6;
        break;
    end
end

%dt=str2double(str(stop1:stop1+17));
% 1  2  3  4  5  6  /7 8 / 9 10 /11 12/ 13 14/ 15 16/ 17 18/ 19 20/ 21 22/ 23 24/ 25 26
% FF-FF-0A-55-50-12-54-00-11-00-74-08-E0-FF-03-00-F5-FF-01-00-00-00-00-00-8A-4A
if receiveData(stop2)==0
   angle_x=receiveData(stop1);
   %angle_x=hex2dec(num2str(angle_x)); 
   
elseif receiveData(stop2)>245
   angle_x=receiveData(stop1); 
   %angle_x=hex2dec(num2str(angle_x));
   angle_x=-1*(angle_x);
end
if receiveData(stop4)==0
   angle_y=receiveData(stop3);
   %angle_y=hex2dec(num2str(angle_y));
   
elseif receiveData(stop4)>245
   z=receiveData(stop3); 
   %angle_y=hex2dec(num2str(angle_y));
   angle_y=-1*(z);
end
if receiveData(stop6)==0
   angle_z=receiveData(stop5); 
   %angle_z=hex2dec(num2str(angle_z)); 
   
elseif receiveData(stop6)>245
   angle_z=receiveData(stop5); 
   %angle_z=hex2dec(num2str(angle_z)); 
   angle_z=-1*(angle_z);
end

out=[-(angle_x+90),angle_y+90,angle_z];





end

