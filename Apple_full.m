%% 이미지 불러오기 및 사이즈 조절
clear all; close all; clc;
appleorigin=imread('damaged.jpg');
apple=imresize(appleorigin, [400 400]); %오픈소스 imresize
imshow(apple)

%% 1)segment image
 %divide image into its respective RGB intensities
%%%%%%%%%%%%%%%%오픈소스 %%%%%%%%%%%%%%%%%%%%%%% 
red=apple(:,:,1); 
green=apple(:,:,2);%오픈소스 색상제거
blue=apple(:,:,3); 
%%%%%%%%%%%%%%%%%% 끝 %%%%%%%%%%%%%%%%%%%%%%% 

figure;
subplot(2,2,1); imshow(apple); title('Original Image');
subplot(2,2,2); imshow(red); title('Red Plane');
subplot(2,2,3); imshow(blue); title('Green Plane');
subplot(2,2,4); imshow(green); title('Blue Plane');

%% 2)binary할 plane 선택
%%%%%%%%%%%%%%%%오픈소스 %%%%%%%%%%%%%%%%%%%%%%% 
%histogram 보여주기
figure;
subplot(2,2,1); imhist(apple); title('Histogram of Orignal Image');%오픈소스 imhist
subplot(2,2,2); imhist(red); title('Histogram of Red Plane');%오픈소스 imhist
subplot(2,2,3); imhist(blue); title('Histogram of Green Plane');%오픈소스 imhist
subplot(2,2,4); imhist(green); title('Histogram of Blue Plane');%오픈소스 imhist

[cntR,binR]= imhist(red); %오픈소스 imhist
[cntB,binB]= imhist(blue); %오픈소스 imhist
[cntG,binG]= imhist(green);%오픈소스 imhist
%%%%%%%%%%%%%%%%%% 끝 %%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%% 직접 짠 부분%%%%%%%%%%%%%%%%%%%%%%% 
%diameter는 어두운 색상 많이 갖고있는 plane 선택
%damage는 어두운 색상 적게 갖고있는 plane 선택
[M,index1] = max([sum(cntR(1:100,:)), sum(cntB(1:100,:)), sum(cntG(1:100,:))]); 
[M,index2] = min([sum(cntR(1:100,:)), sum(cntB(1:100,:)), sum(cntG(1:100,:))]);

if index1 == 1
    thPlane1 = red;
elseif index1 == 2
    thPlane1 = blue;
else 
    thPlane1 = green;
end

if index2 == 1
    thPlane2 = red;
elseif index2 == 2
    thPlane2 = blue;
else 
    thPlane2 = green;
end

figure; 
subplot(2,1,1); imshow(thPlane1); title('diameter plane') %binary할 diameter plane보여줌
subplot(2,1,2); imshow(thPlane2); title('damage plane')% binary할 damage plane보여줌


%% 5) 함수 사용해서 결과 추출
damage_count = damage(apple, thPlane2);  
diameter = diameter(apple, thPlane1);

%daimeter classification
if(diameter>300)
    class='A';
    result = 'A'
elseif(diameter>200)
    class='B'; 
    result = 'B'
else 
    class='C';
    result = 'C'
end

%damage 여부
if damage_count > 0 
    status = '썩은 사과이다'
    result = 'F'
else
    status ='썩지 않은 사과이다'
end 
msgbox(sprintf('이 사과의 크기는 %c이다. 이 사과는 %s.\n 따라서 이 사과의 등급은 %c이다.',class , status, result)) ;
doc sprintf;

%%%%%%%%%%%%%%%% 끝 %%%%%%%%%%%%%%%%%% 
