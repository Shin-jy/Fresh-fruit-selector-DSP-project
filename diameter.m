function [diameter] = diameter(apple,thPlane)
%%%이 코드는 전부 오픈소스이지만 
%%%% image processing tool box의 내장함수를 사용한 순서는 저희 팀이 짰습니다
%% 3) 이미지 바이너리화
%%%%%%%%%%%%%%%%%%%%%%% 오픈소스 %%%%%%%%%%%%%%%%%%%% 

%임계값으로 바이너리화 threshold the chosen plane
figure;
bw1=imbinarize(thPlane,0.65);%binary할 plane의 임계값은 test를 통해 추출
subplot(2,2,1); imshow(bw1); title('chosen plane for diameter of apple');

%작은 구멍을 채운다 
bw2 = imcomplement(bw1); %색 반전이 필요 
fill=imfill(bw2, 'holes'); %fill any holes
subplot(2,2,2); imshow(fill); title('Holes filled');

%이미지의 경계에서 모든 blobs제거(경계 깔끔히 한다) remove any alobs on the border of the image
clear1=imclearborder(fill);
subplot(2,2,3); imshow(clear1); title('Remove BLOBs on border'); 

%이미지에서 7픽셀보다 작은 blob들을 제거(7픽셀보다 작은 disk형태들을채운다) Remove blobs that are smaller than 7 pixels across
se=strel('disk',7);
open=imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small BLOBs');

%% 4) 사과 직경 재기 Measure apple diameter
stats=regionprops(open, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
center=stats.Centroid
diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameter/2;
%Show result
figure;
imshow(apple); hold on;
viscircles(center,radii)
hold off

%%%%%%%%%%%%%%%% 끝 %%%%%%%%%%%%%%