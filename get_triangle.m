function triangle = get_triangle(X, Y, m, color)
    % корректно работает только при заранее выполненных командах:
    % axis([-n,n,-n,n]);
    % axis square;
    if (X(2) >= X(1)) && (Y(2) >= Y(1))
        angle = atan(abs(Y(2)-Y(1))/(X(2)-X(1)));
    elseif (X(2) >= X(1)) && (Y(2) < Y(1))
        angle = atan(-abs(Y(2)-Y(1))/(X(2)-X(1)));
    elseif (X(2) < X(1)) && (Y(2) >= Y(1))
        angle = atan(abs(Y(2)-Y(1))/(X(2)-X(1))) + pi;
    else
        angle = atan(-abs(Y(2)-Y(1))/(X(2)-X(1))) + pi;
    end
    x = X(1); y = Y(1);
    A = zeros(5,2);
    A(1,1) = x + 2*m*cos(angle); A(1,2) = y + 2*m*sin(angle);
    A(2,1) = x + m*cos(angle - 2*pi/3); A(2,2) = y + m*sin(angle - 2*pi/3);
    A(3,1) = x; A(3,2) = y;
    A(4,1) = x + m*cos(angle + 2*pi/3); A(4,2) = y + m*sin(angle + 2*pi/3);
    A(5,1) = A(1,1); A(5,2) = A(1,2);
    triangle = fill(A(:,1), A(:,2), color);
end