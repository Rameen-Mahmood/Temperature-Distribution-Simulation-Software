%The software models the temperature distribution in a thin metal plate
% with isothermal temperatures on each side. The simulation continues until
% a thermal equilibrium is reached.

N = 0;
M = 0;

%Verifying if user enters a valid number of rows and columns, i.e between
%50 and 200.
while (N <50 || N>200)
    N = input('Enter the number of rows\n');
end
while (M <50 || M>200)
    M = input('Enter the number of columns\n');
end
temperatures = [0 0 0 0];
temperatures(1) = input('Enter the temperature of the first row\n');
%Verifying if user enters valid temperatures — between 0 and 255.
while ((temperatures(1)< 0) || (temperatures(1) >255))
    temperatures(1) = input('Invalid temperature, enter again.\n');
end
temperatures(2) = input('Enter the temperature of the last row\n');
while ((temperatures(2)< 0) || (temperatures(2) >255))
    temperatures(2) = input('Invalid temperature, enter again.\n');
end
temperatures(3) = input('Enter the temperature of the first column\n');
while ((temperatures(3)< 0) || (temperatures(3) >255))
     temperatures(3) = input('Invalid temperature, enter again.\n');
end
temperatures(4) = input('Enter the temperature of the last column\n');
while ((temperatures(4)< 0) || (temperatures(4) >255))
     temperatures(4) = input('Enter the temperature of the last column\n');
end
simulation_threshold = input('Enter the threshold\n');
time=0;
matrix = zeros(N,M);

% Create a grid according to the temperature values
matrix(1,:)=temperatures(1);
matrix(N,:)=temperatures(2);
matrix(:,1)=temperatures(3);
matrix(:,M)=temperatures(4);

%Display boundary conditions of grid when time is 0
subplot(2,2,1)
image(matrix)
title(['Boundary conditions at Time = ',num2str(time)])
colormap(jet),colorbar

%Display surface conditions of grid when time is 0
subplot(2,2,2)
contour(matrix)
title(['Surface Contours at Time = ',num2str(time)])

%initialize "initial" matrix with zeros
initial = zeros(N,M);

value=true;
% Keep updating the grid until thermal equilibrium is achieved
while value
    
            %Storing the current grid in the initial grid
            initial(2:(N-1),2:(M-1)) = matrix(2:(N-1),2:(M-1));
            %Calculating the average of the all the adjacent points and storing it into a new
            %grid called average_temp
            average_temp(2:(N-1),2:(M-1)) = (matrix(2:(N-1),1:(M-2))+matrix(2:(N-1),3:M)+matrix(1:(N-2),2:(M-1))+matrix(3:N,2:(M-1)))/4;
            %Storing the average into the current grid
            matrix(2:(N-1),2:(M-1))= average_temp(2:(N-1),2:(M-1));
            %Calculating the difference
            difference(2:(N-1),2:(M-1)) = matrix(2:(N-1),2:(M-1)) - initial(2:(N-1),2:(M-1));
            
            %incrementing the time
            time = time + 1;
    
            %Displaying the heat dissipation of the grid with time
            subplot(2,2,3)
            image(matrix)
            title(['Heat dissipation at Time = ',num2str(time)])
            colormap(jet),colorbar
            drawnow;
            
            %Displaying the surface counters with time
            subplot(2,2,4)
            contour(matrix)
            title(['Surface Contours at Time = ',num2str(time)])
            set(gca,'Ydir','reverse')
            drawnow;
            
            %if the difference is less than the simulation threshold, then
            %break the loop
            if all(difference < simulation_threshold)
                value = false;
            end
end      