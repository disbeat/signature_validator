%Implementation of the modified direction feature. This algorithm finds the changes of 
%direction in a line. The directions can be of 4 types:
%vertical -> 2
%right diagonal -> 3
%horizontal -> 4
%left diagonal -> 5



function [location_transitions,  direction_transitions]= mdf_feature(img, num_lines)
    
    thinned_image = get_skeleton(img);

	%just to work accordingly to paper

    %find the lower left pixel that has the value 1
	start_pixel = find_start_pixel(thinned_image);
	thinned_image( start_pixel(1), start_pixel(2)) = -1;
	segmented_image = get_df(start_pixel, thinned_image);
	
	
	[location_transitions, direction_transitions] = analyse_matrix_transictions(segmented_image);
    
	location_transitions = averaging_features(location_transitions, num_lines);
	direction_transitions = averaging_features(direction_transitions, num_lines);

end

function feature_structure = averaging_features(feature_structure, num_lines)
	result = [];
	field_names = fieldnames(feature_structure);
	for k = 1 : size(field_names,1)
		temp = getfield(feature_structure, char(field_names(k)));
		result = average_lines(temp, num_lines);
		feature_structure = setfield(feature_structure, char(field_names(k)), result);
	end

end

function segmented_image = clean_start_points(segmented_image)
	intersections = 9;
	for r = 1 : size(segmented_image, 1)
		c = find(segmented_image(r, : ) == -1);
		for k = 1 : length(c)
			segmented_image(r, c(k)) = intersections;
		end
	end
end


function s_pixel = find_start_pixel(img)
	for r = size(img,1) : -1 : 1
		c = find(img(r, : ) == 1);
		if(isempty(c) == 0)
			s_pixel = [r c(1)];
			return;
		end
	end
end


function img = get_df(pixel, img)
	%img
	%pause;	
	
	point = struct('row', pixel(1), 'col', pixel(2), 'segment', 1, 'previous_dir', struct('direction',1,'number',0,'length',0));
	segments = [struct('segment', [point])];
	
   	queue = [point];
	
	img( point.row, point.col) = -1;
	
	
	while (length(queue) > 0)
		%img
		%segments
		%pause
		point = queue(1);
		queue(1) = [];
		

		neighbours = find_neighbours(point, img);
		for i = 1 : length(neighbours)
			img( neighbours(i).row, neighbours(i).col ) = 9;
			
		end
        
        
        
		if length(neighbours) == 1 
			neighbours(1).previous_dir = refresh_previous_direction( point.previous_dir, get_direction(point, neighbours(1)));
	
			img( neighbours(1).row, neighbours(1).col ) = neighbours(1).previous_dir.direction;
	
			queue = [neighbours(1), queue];
			

			this_segment = segments(neighbours(1).segment).segment;
			this_segment = [this_segment, neighbours(1)];
			segments(neighbours(1).segment).segment = this_segment;
		elseif length(neighbours) > 1
			change = false;
			for i = 1 : length(neighbours)
				
				neighbours(i).previous_dir.direction = get_direction(point, neighbours(i));
				%neighbours(i).previous_dir.direction
				%point.previous_dir.direction
				%pause
				if new_segment(point, neighbours(i)) || change
					img = normalize_segment(segments(neighbours(i).segment).segment,img);
					
					segments = [segments, struct('segment', [neighbours(i)])];
					neighbours(i).segment = length(segments);
					queue = [queue, neighbours(i)];
					
					img( neighbours(i).row, neighbours(i).col ) = -1;
					
				else
					change = true;
					neighbours(i).previous_dir = refresh_previous_direction( point.previous_dir, get_direction(point, neighbours(i)));
					img( neighbours(i).row, neighbours(i).col ) = neighbours(i).previous_dir.direction;
					queue = [neighbours(i), queue];
					this_segment = segments(neighbours(i).segment).segment;
					this_segment = [this_segment, neighbours(i)];
					segments(neighbours(i).segment).segment = this_segment;
					
				end
			end
		else
			if length(segments(point.segment).segment) ~= 0
				img = normalize_segment(segments(point.segment).segment,img);
			end
		end
		
	end
end


function img = normalize_segment(pixels_segment, img)
	count = zeros(1,5);	
	count(1) = -1;
	for i = 2 : length(pixels_segment)
		r = pixels_segment(i).row;
		c = pixels_segment(i).col;
		count( img( r, c ) ) = 	count( img( r, c ) ) + 1;
	end
	[values, index] = max(count);
	if(count(index(1)) > 0)
		img(pixels_segment(1).row, pixels_segment(1).col) = index(1);
	else
		img(pixels_segment(1).row, pixels_segment(1).col) = 9;
	end
	
end


function previous_direction = refresh_previous_direction(previous_direction, next_direction)
    if previous_direction.direction == next_direction
        previous_direction.length = previous_direction.length + 1;
    else
		previous_direction = struct('direction', next_direction, 'number', previous_direction.number, 'length', 0);
    end
end

function direction = get_direction(pixel, next)
	difference_y = pixel.col - next.col;
    difference = abs(pixel.row - next.row + difference_y);

    direction = difference + 3;
    if difference == 1 && difference_y == 0
        direction = 2;
    end
end


function result  = find_neighbours(pixel, img)
	result = [];
	%checks if the actual pixel has more than to neighbours. If yes, it is an intersection point
	neighbours = [-1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1; -1 -1];
	conta = 0;
	for i = 1 : size(neighbours,1)
		try
			if(img(pixel.row + neighbours(i,1), pixel.col + neighbours(i,2)) == 1)
				
				new_neigh = struct('row', pixel.row + neighbours(i,1), 'col', pixel.col + neighbours(i,2),'segment',pixel.segment, 'previous_dir', struct('direction',1,'number',0,'length',0));
				
				result = [result , new_neigh];
			end
		catch exception
			continue
		end
	end
end



function result = new_segment(pixel, next_pixel)
	result = first_condition(pixel, next_pixel) || second_condition(pixel, next_pixel);
    result = result || third_condition(pixel) || fourth_condition(pixel);
end


function result = first_condition(pixel, next_pixel)
    result = (pixel.previous_dir.direction == 3) && (next_pixel.previous_dir.direction == 5);
end


function result = second_condition(pixel, next_pixel)
    result = (next_pixel.previous_dir.direction == 3) && (pixel.previous_dir.direction == 5);
end


function result = third_condition(pixel)
    result = pixel.previous_dir.number > 3;
end


function result = fourth_condition(pixel)
    result = (pixel.previous_dir.length > 3);
end



function [location_transitions, direction_transitions] = analyse_matrix_transictions(matrix)
	%lr = left to right
	%rl = right to left
	%tb = top to bottom
	%bt = bottom to top
	location_transitions = struct('left_right', [], 'right_left', [], 'top_bottom', [], 'bottom_top', []);
	direction_transitions = struct('left_right', [], 'right_left', [], 'top_bottom', [], 'bottom_top', []);
	for i = 1:size(matrix,1)
		row = matrix(i,:);	
		[lt_lr lt_rl dt_lr dt_rl] = analyse_lines(row);
		location_transitions.left_right = [ location_transitions.left_right ; lt_lr];
		location_transitions.right_left = [ location_transitions.right_left ; lt_rl];
		
		direction_transitions.left_right = [ direction_transitions.left_right ; dt_lr];
		direction_transitions.right_left = [ direction_transitions.right_left ; dt_rl];
		
	end

	for i = 1:size(matrix,2)
		col = matrix(:,i); 
		[lt_tb lt_bt dt_tb dt_bt] = analyse_lines(col);
		
		location_transitions.top_bottom = [ location_transitions.top_bottom ; lt_tb];
		location_transitions.bottom_top = [ location_transitions.bottom_top ; lt_bt];
		
		direction_transitions.top_bottom = [ direction_transitions.top_bottom ; dt_tb];
		direction_transitions.bottom_top = [ direction_transitions.bottom_top ; dt_bt];
		
	end
end





function [lt_normal lt_inverse dt_normal dt_inverse] = analyse_lines(line)
	%lines can be either columns or rows
	%directions are:
	%left to right
	%right to left
	%top to bottom
	%bottom to top
	len = length(line);

	p1 = get_transition_points( line );
	p2 = get_transition_points( line(len:-1:1) );
   
	lt_normal = get_location_transitions(p1, len);
	lt_inverse = get_location_transitions(p2, len);
   
	dt_normal = get_direction_transitions(p1);
	dt_inverse = get_direction_transitions(p2);
end

%transitions -> Nx2 [index, value in matrix]
function transitions = get_transition_points(line)
	transitions = zeros(3,2);
	count = 1; 
	i = 1;
	while count <= 3 && i < length(line)
		
		if line(i) == 0 && line(i+1) > 0
			transitions(count,1) = i + 1;
			transitions(count,2) = line(i + 1);
			count = count + 1;
		end
		i = i+1;
	end

end


function lt = get_location_transitions(transitions, line_length)

	lt = zeros(1,3);
	size(transitions);
	for i = 1 : min(size(transitions,1), 3)
		lt(i) = 1 - (transitions(i,1) / line_length);
	end
end


function dt = get_direction_transitions(transitions)
   dt = zeros(1,3);
   for i = 1 : min(size(transitions,1), 3)
       dt(i) = transitions(i,2) / 10;
   end
end




