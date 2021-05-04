function [ damage_count ] = damage(apple,thPlane)
%%%�� �ڵ�� ���� ���¼ҽ������� 
%%%% image processing tool box�� �����Լ��� ����� ������ ���� ���� ®���ϴ�
%% 3) �̹��� ���̳ʸ�ȭ 
%%%%%%%%%%%%%%%%%%%%%%% ���¼ҽ� %%%%%%%%%%%%%%%%%%%% 

%�Ӱ谪���� ���̳ʸ�ȭ
figure;
bw1=imbinarize(thPlane,0.35); %binary�� plane�� �Ӱ谪�� test�� ���� ����
subplot(2,2,1); imshow(bw1); title('choosen plane for damaged apple detection');

%���� ������ ä��� 
bw2 = imcomplement(bw1);%�� ���� �ʿ�
fill=imfill(bw2, 'holes');  %fill any holes
subplot(2,2,2); imshow(fill); title('Holes filled');

%�̹��� ��迡�� ����ϰ�  
clear1 =imclearborder(fill);
subplot(2,2,3); imshow(clear1); title('Remove blocs on border');

%7�ȼ����� ���� BLOBs ���� 
se=strel('disk',7);
open=imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small blobs');

%% 4) �ջ�κ� �߰�
[B]=bwboundaries(open);   
damage_count = length(B);
figure;
imshow(apple);
hold on;
for k=1:length(B), boundary = B{k};
     plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%% �� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

