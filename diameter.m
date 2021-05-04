function [diameter] = diameter(apple,thPlane)
%%%�� �ڵ�� ���� ���¼ҽ������� 
%%%% image processing tool box�� �����Լ��� ����� ������ ���� ���� ®���ϴ�
%% 3) �̹��� ���̳ʸ�ȭ
%%%%%%%%%%%%%%%%%%%%%%% ���¼ҽ� %%%%%%%%%%%%%%%%%%%% 

%�Ӱ谪���� ���̳ʸ�ȭ threshold the chosen plane
figure;
bw1=imbinarize(thPlane,0.65);%binary�� plane�� �Ӱ谪�� test�� ���� ����
subplot(2,2,1); imshow(bw1); title('chosen plane for diameter of apple');

%���� ������ ä��� 
bw2 = imcomplement(bw1); %�� ������ �ʿ� 
fill=imfill(bw2, 'holes'); %fill any holes
subplot(2,2,2); imshow(fill); title('Holes filled');

%�̹����� ��迡�� ��� blobs����(��� ����� �Ѵ�) remove any alobs on the border of the image
clear1=imclearborder(fill);
subplot(2,2,3); imshow(clear1); title('Remove BLOBs on border'); 

%�̹������� 7�ȼ����� ���� blob���� ����(7�ȼ����� ���� disk���µ���ä���) Remove blobs that are smaller than 7 pixels across
se=strel('disk',7);
open=imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small BLOBs');

%% 4) ��� ���� ��� Measure apple diameter
stats=regionprops(open, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
center=stats.Centroid
diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameter/2;
%Show result
figure;
imshow(apple); hold on;
viscircles(center,radii)
hold off

%%%%%%%%%%%%%%%% �� %%%%%%%%%%%%%%