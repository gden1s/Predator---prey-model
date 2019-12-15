% ������ ������-������
N = 9999;
%k_ = (N+1)/1000; % �������� ��������
k_ = 16;
x = zeros(1,N+1);
y = zeros(1,N+1);
% ������� �������� ����������
a1 = 0.01;  a2 = 0.02;
b1 = 0.002; b2 = 0.001;
% ��
x(1) = 26; y(1) = 7;

% �������
for k = 1:N
    % �������� ������
    x(k+1) = x(k) + a1*x(k) - b1*x(k)*y(k);
    % �������� �������
    y(k+1) = y(k) - a2*y(k) + b2*x(k)*y(k);
end

% ������� 
figure('Position', [100, 150, 810, 400],...
        'NumberTitle', 'off', 'Name',...
        '������ ������-������', 'Color', [.62 .79 .86]);
hold on;
grid on; 
plot(1:N+1, x(1:N+1), 'LineWidth',1,'Color','r','DisplayName','������');
plot(1:N+1, y(1:N+1), 'LineWidth',1,'Color','g','DisplayName','������');
legend
% ������� ����������
figure('Position', [510, 150, 400, 400],...
        'NumberTitle', 'off', 'Name',...
        '������� ����������', 'Color', [.62 .79 .86]);
hold on;
grid on; 
axis equal;
plot(x(1:N+1), y(1:N+1), 'LineWidth',0.5,'Color','b');
xlabel('������'); 
ylabel('������');
get_triangle([x(1) x(2)], [y(1) y(2)], 0.75, 'g');
for i = floor(N/10:N/10:N-1)
    get_triangle([x(i) x(i+1)], [y(i) y(i+1)], 0.75, 'm');
end
get_triangle([x(N-1) x(N)], [y(N-1) y(N)], 0.75, 'r');


%%% �������� ������� ���������� %%%
% ��������� �������� 
% k_ = 10; % �������� ��������
T = 1:N+1;
% Set up first frame
figure('Position', [920, 150, 400, 400], 'NumberTitle', 'off', 'Name',...
       '�������� ������� ����������', 'Color', [.62 .79 .86]);
axis equal;
hold on;
grid on;
plot(x, y, 'LineWidth', 1);
line(x(1), y(1), 'Marker', '.', 'MarkerSize', 25, 'Color', 'g');
line(x(N+1), y(N+1), 'Marker', '.', 'MarkerSize', 25, 'Color', 'r');
dot = line(x(1), y(1), 'Marker', '.', 'MarkerSize', 25, 'Color', 'm');
xlabel('������'); 
ylabel('������');
ht = title(sprintf('�����: %0.0f ����', T(1)));

% Get figure size
pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);

% Preallocate data (for storing frame data)
mov = zeros(1.25*height, 1.25*width, 1, (length(T)/k_), 'uint8');

% Loop through by changing XData and YData
for i = 1:(length(T)/k_)
    % Upgrade graphics data
    set(dot, 'XData', x(k_*i), 'YData', y(k_*i));
    set(ht, 'String', sprintf('�����: %0.0f ����', T(k_*i)));
  
    % Get frame as an image
    f = getframe(gcf);
    
    % Create a colormap for the first frame. For the rest of the frames,
    % use the same colormap
    if i == 1
        [mov(:, :, 1, i), map] = rgb2ind(f.cdata, 256, 'nodither');
    else
        mov(:, :, 1, i) = rgb2ind(f.cdata, map, 'nodither');
    end
end

% Create animated GIF
imwrite(mov, map, 'animation.gif', 'DelayTime', 0, 'LoopCount', inf);