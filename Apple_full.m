%% �̹��� �ҷ����� �� ������ ����
clear all; close all; clc;
appleorigin=imread('damaged.jpg');
apple=imresize(appleorigin, [400 400]); %���¼ҽ� imresize
imshow(apple)

%% 1)segment image
 %divide image into its respective RGB intensities
%%%%%%%%%%%%%%%%���¼ҽ� %%%%%%%%%%%%%%%%%%%%%%% 
red=apple(:,:,1); 
green=apple(:,:,2);%���¼ҽ� ��������
blue=apple(:,:,3); 
%%%%%%%%%%%%%%%%%% �� %%%%%%%%%%%%%%%%%%%%%%% 

figure;
subplot(2,2,1); imshow(apple); title('Original Image');
subplot(2,2,2); imshow(red); title('Red Plane');
subplot(2,2,3); imshow(blue); title('Green Plane');
subplot(2,2,4); imshow(green); title('Blue Plane');

%% 2)binary�� plane ����
%%%%%%%%%%%%%%%%���¼ҽ� %%%%%%%%%%%%%%%%%%%%%%% 
%histogram �����ֱ�
figure;
subplot(2,2,1); imhist(apple); title('Histogram of Orignal Image');%���¼ҽ� imhist
subplot(2,2,2); imhist(red); title('Histogram of Red Plane');%���¼ҽ� imhist
subplot(2,2,3); imhist(blue); title('Histogram of Green Plane');%���¼ҽ� imhist
subplot(2,2,4); imhist(green); title('Histogram of Blue Plane');%���¼ҽ� imhist

[cntR,binR]= imhist(red); %���¼ҽ� imhist
[cntB,binB]= imhist(blue); %���¼ҽ� imhist
[cntG,binG]= imhist(green);%���¼ҽ� imhist
%%%%%%%%%%%%%%%%%% �� %%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%% ���� § �κ�%%%%%%%%%%%%%%%%%%%%%%% 
%diameter�� ��ο� ���� ���� �����ִ� plane ����
%damage�� ��ο� ���� ���� �����ִ� plane ����
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
subplot(2,1,1); imshow(thPlane1); title('diameter plane') %binary�� diameter plane������
subplot(2,1,2); imshow(thPlane2); title('damage plane')% binary�� damage plane������


%% 5) �Լ� ����ؼ� ��� ����
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

%damage ����
if damage_count > 0 
    status = '���� ����̴�'
    result = 'F'
else
    status ='���� ���� ����̴�'
end 
msgbox(sprintf('�� ����� ũ��� %c�̴�. �� ����� %s.\n ���� �� ����� ����� %c�̴�.',class , status, result)) ;
doc sprintf;

%%%%%%%%%%%%%%%% �� %%%%%%%%%%%%%%%%%% 
