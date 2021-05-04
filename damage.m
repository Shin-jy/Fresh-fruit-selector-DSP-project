function [ damage_count ] = damage(apple,thPlane)
%%%이 코드는 전부 오픈소스이지만 
%%%% image processing tool box의 내장함수를 사용한 순서는 저희 팀이 짰습니다
%% 3) 이미지 바이너리화 
%%%%%%%%%%%%%%%%%%%%%%% 오픈소스 %%%%%%%%%%%%%%%%%%%% 

%임계값으로 바이너리화
figure;
bw1=imbinarize(thPlane,0.35); %binary할 plane의 임계값은 test를 통해 추출
subplot(2,2,1); imshow(bw1); title('choosen plane for damaged apple detection');

%작은 구멍을 채운다 
bw2 = imcomplement(bw1);%색 반전 필요
fill=imfill(bw2, 'holes');  %fill any holes
subplot(2,2,2); imshow(fill); title('Holes filled');

%이미지 경계에서 깔끔하게  
clear1 =imclearborder(fill);
subplot(2,2,3); imshow(clear1); title('Remove blocs on border');

%7픽셀보다 작은 BLOBs 제거 
se=strel('disk',7);
open=imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small blobs');

%% 4) 손상부분 발견
[B]=bwboundaries(open);   
damage_count = length(B);
figure;
imshow(apple);
hold on;
for k=1:length(B), boundary = B{k};
     plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%% 끝 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

