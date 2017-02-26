function [state,m,n] = gaplotshortroute(options,state,flag,m,n,x_goal,y_goal,x_start,y_start,obstacle,square)

if(strcmp(flag,'init')) % Set up the plot
    fig = gcf; % current figure handle
    fig.Color = [0 0.5 0.5];
    fig.Position = [50 50 2560 1440];
    fig.ToolBar = 'none';
    axis([0 m 0 n]);
    hold on;
    
    plot(x_start,y_start,'k.','MarkerSize',20)
    plot(x_goal,y_goal,'r.','MarkerSize',20)
    r = 0.4;
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x_goal;
    yunit = r * sin(th) + y_goal;
    fill(xunit, yunit,'r','LineStyle','none');
    pause(1);
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    pause(1)
end

    obs = [obstacle; [NaN NaN]; square];
    r = 0.4;
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x_goal;
    yunit = r * sin(th) + y_goal;


all_polyline = [];
for j = 1:size(state.Population,1)
    prev = [x_start y_start];
    polyline = prev;

    for i=state.Population(j,:)
        point = [prev(1)+cos(i) prev(2)+sin(i)];
        polyline = [polyline; point];
        prev = point;
    end
    
    yi = [];
    xi = [];

    if isempty(obs)
        
    else
        [xi, yi] = polyxpoly(polyline(:,1), polyline(:,2), obs(:,1), obs(:,2));
    end

    if isempty(yi)
        I = [];
    else
        I = find(polyline(:,2) >= min(yi));
        polyline(I,:) = [];

        first_intersect = find(yi == min(yi));
        first_intersect_x = xi(first_intersect);
        first_intersect_y = yi(first_intersect);
        polyline = [polyline; [first_intersect_x first_intersect_y]];
    end
    

    [xb, yb] = polyxpoly(polyline(:,1), polyline(:,2), xunit, yunit);
    
    if isempty(yb)
        I = [];
    else
        I = find(polyline(:,2) >= min(yb));
        polyline(I,:) = [];

        first_intersect = find(yb == min(yb));
        first_intersect_x = xb(first_intersect);
        first_intersect_y = yb(first_intersect);
        polyline = [polyline; [first_intersect_x first_intersect_y]];
    end
    
    %uncomment to show the growth of each snake
    %for i = 1:size(polyline,1)-1
        %mapshow(polyline(i:i+1,1),polyline(i:i+1,2),'LineWidth',1);
        %pause(0.01);
    %end
    all_polyline = [all_polyline; [NaN NaN]; polyline];

    
end
    pause(0.0)
    all_polyline = all_polyline(2:end,:);
    
    %printing the current population
    mapshow(all_polyline(:,1),all_polyline(:,2),'LineWidth',1)
    %-----------------------
    
    %draw obstacles after each iteration
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    %----------------------------
    pause(0.1);
    
    %graying the current population
    mapshow(all_polyline(:,1),all_polyline(:,2),'Color',[0.9 0.9 0.9],'LineWidth',1)
    %-------------------
    
    %draw obstacles after each iteration
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    %----------------------------
    pause(0.1);
    
    if(strcmp(flag,'done'))
        %printing the best final population
        mapshow(all_polyline(:,1),all_polyline(:,2),'LineWidth',1);
        %-------------------
        %draw obstacles after each iteration
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    %----------------------------
        pause(1);
        %graying the best final population
        mapshow(all_polyline(:,1),all_polyline(:,2),'LineWidth',1,'Color',[0.9 0.9 0.9]);
        %--------------
        %draw obstacles after each iteration
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    %----------------------------
        pause(1);
        state.Score(1) = 100000000000;
        state.Score
        [~, ind] = min(state.Score);
        [row, ~] = find(isnan(all_polyline));
        row = row(1:end/2);

        %printing the best solution
        mapshow(all_polyline(row(ind-1)+1:row(ind)-1,1),all_polyline(row(ind-1)+1:row(ind)-1,2),'LineWidth',1);
        %---------------
    end
    %draw obstacles after each iteration
    if isempty(obstacle)
    else
        fill(obstacle(1:5,1),obstacle(1:5,2),'r','LineStyle','none')
        fill(obstacle(7:end,1),obstacle(7:end,2),'r','LineStyle','none')
    end
    mapshow(square(:,1),square(:,2),'LineWidth',5,'Color','black')
    %----------------------------

end
