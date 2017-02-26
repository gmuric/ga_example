function f = GA_solution_short_route(x,x_start,y_start,x_goal,y_goal,obstacle,square)

    obs = [obstacle; [NaN NaN]; square];
    
    prev = [x_start y_start];
    polyline = prev;
    for i=x
        point = [prev(1)+cos(i) prev(2)+sin(i)];
        polyline = [polyline; point];
        prev = point;
    end
    
    yi = [];
    xi = [];
    if isempty(obstacle)
    else
        [xi, yi] = polyxpoly(polyline(:,1), polyline(:,2), obs(:,1), obs(:,2));
    end


    if isempty(yi)
        I = [];
    else
        I = find(polyline(:,2) >= min(yi));
    end
    
   
    polyline(I,:) = [];

    first_intersect = find(yi == min(yi));
    first_intersect_x = xi(first_intersect);
    first_intersect_y = yi(first_intersect);
    polyline = [polyline; [first_intersect_x first_intersect_y]];

    y_pos = polyline(end,2);
    x_pos = polyline(end,1);
    f1 = dist(polyline,[x_goal;y_goal]);
    f = min(f1);
    
end