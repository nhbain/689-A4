function linkages(scene)
if nargin < 1
	scene = 0;
end

% Set up the scene here.
% Note that links don't have to be placed exactly. The first call to
% solveLinkage() will automatically snap the links so that all the
% constraints are satisfied.
links = [];
pins = [];
sliders = [];
particles = [];
oscillation = false; %False by default
switch scene
	case 0
		% Crank-rocker
		% Bottom link
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-1 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  2.0  2.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Left link
		links(2).angle = pi/2;
		links(2).pos = [-1 0]';
		links(2).verts = [
			 0.0  1.0  1.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Right link
		links(3).angle = pi/2;
		links(3).pos = [1 0]';
		links(3).verts = [
			 0.0  2.0  2.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Top link
		links(4).angle = 0;
		links(4).pos = [-1 1]';
		links(4).verts = [
			 0.0  3.0  3.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		
		% Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
		
		% Bottom-left
		pins(1).linkA = 1;
		pins(1).linkB = 2;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
		% Bottom-right
		pins(2).linkA = 1;
		pins(2).linkB = 3;
		pins(2).pointA = [2,0]';
		pins(2).pointB = [0,0]';
		% Left-top
		pins(3).linkA = 2;
		pins(3).linkB = 4;
		pins(3).pointA = [1,0]';
		pins(3).pointB = [0,0]';
		% Right-top
		pins(4).linkA = 3;
		pins(4).linkB = 4;
		pins(4).pointA = [1+rand(1),0]'; % pin location on link3 is randomized
		pins(4).pointB = [2,0]';
		
		% List of tracer particles for display
		particles(1).link = 4; % which link?
		particles(1).point = [0.5,0.1]'; % tracer particle point in local coords
		particles(2).link = 4;
		particles(2).point = [2.5,-0.1]';
	case 1
		% Drag-link
        % Bottom link. Height: .2, Length: 3.0, Angle: 0�
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-1 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  3.0  3.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Left link. Height: .2, Length: 5.0, Angle: 90�
		links(2).angle = pi/2;
		links(2).pos = [-1 0]';
		links(2).verts = [
			 0.0  5.0  5.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Right link. Height: .2, Length: 6.0, Angle: 90�
		links(3).angle = pi/2;
		links(3).pos = [1 0]';
		links(3).verts = [
			 0.0  6.0  6.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Top link. Height: .2, Length: 5.0, Angle: 0�
		links(4).angle = 0;
		links(4).pos = [-1 1]';
		links(4).verts = [
			 0.0  5.0  5.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		
		% Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
		
		% Bottom-left
		pins(1).linkA = 1;
		pins(1).linkB = 2;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
		% Bottom-right
		pins(2).linkA = 1;
		pins(2).linkB = 3;
		pins(2).pointA = [3,0]';
		pins(2).pointB = [0,0]';
		% Left-top
		pins(3).linkA = 2;
		pins(3).linkB = 4;
		pins(3).pointA = [5,0]';
		pins(3).pointB = [0,0]';
		% Right-top
		pins(4).linkA = 3;
		pins(4).linkB = 4;
		pins(4).pointA = [6,0]';
		pins(4).pointB = [5,0]';
		
		% List of tracer particles for display
		particles(1).link = 4; % which link?
		particles(1).point = [0.0,0.0]'; % tracer particle point in local coords
		particles(2).link = 4;
		particles(2).point = [5,0]';
	case 2
		% Double-rocker
        oscillation = true;
        max_theta = pi/2 + 0.315;
        min_theta =  pi/3 - .23;
        
        % Bottom link. Height: .2, Length: 2.0, Angle: 0�
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-1 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  2.0  2.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Left link. Height: .2, Length: 4.0, Angle: 60�
		links(2).angle = pi/3;
		links(2).pos = [-1 0]';
		links(2).verts = [
			 0.0  4.0  4.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Right link. Height: .2, Length: 4.0, Angle: 90�
		links(3).angle = pi/2;
		links(3).pos = [1 0]';
		links(3).verts = [
			 0.0  4.0  4.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Top link. Height: .2, Length: 1.0, Angle: 0�
		links(4).angle = 0;
		links(4).pos = [-1 1]';
		links(4).verts = [
			 0.0  1.0  1.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		
		% Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
		
		% Bottom-left
		pins(1).linkA = 1;
		pins(1).linkB = 2;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
		% Bottom-right
		pins(2).linkA = 1;
		pins(2).linkB = 3;
		pins(2).pointA = [2,0]';
		pins(2).pointB = [0,0]';
		% Left-top
		pins(3).linkA = 2;
		pins(3).linkB = 4;
		pins(3).pointA = [4,0]';
		pins(3).pointB = [0,0]';
		% Right-top
		pins(4).linkA = 3;
		pins(4).linkB = 4;
		pins(4).pointA = [4,0]';
		pins(4).pointB = [1.0,0]';
		
		% List of tracer particles for display
		particles(1).link = 4; % which link?
		particles(1).point = [0,0]'; % tracer particle point in local coords
		particles(2).link = 4;
		particles(2).point = [1,0]';
	case 3
		% Bottom link. Height: .2, Length: 4.0, Angle: 0�
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-1 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  4.0  4.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Left link. Height: .2, Length: 2.0, Angle: 90�
		links(2).angle = pi/2;
		links(2).pos = [-1 0]';
		links(2).verts = [
			 0.0  2.0  2.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Right link. Height: .2, Length: 5.0, Angle: 90�
		links(3).angle = pi/2;
		links(3).pos = [1 0]';
		links(3).verts = [
			 0.0  5.0  5.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		% Top link. Height: .2, Length: 10.0, Angle: 0�
		links(4).angle = 0;
		links(4).pos = [-1 1]';
		links(4).verts = [
			 0.0  10.0  10.0  0.0
			-0.1 -0.1  0.1  0.1
			];
		
		% Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
		
		% Bottom-left
		pins(1).linkA = 1;
		pins(1).linkB = 2;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
		% Bottom-right
		pins(2).linkA = 1;
		pins(2).linkB = 3;
		pins(2).pointA = [4,0]';
		pins(2).pointB = [0,0]';
		% Left-top
		pins(3).linkA = 2;
		pins(3).linkB = 4;
		pins(3).pointA = [2,0]';
		pins(3).pointB = [0,0]';
		% Right-top
		pins(4).linkA = 3;
		pins(4).linkB = 4;
		pins(4).pointA = [5,0]';
		pins(4).pointB = [5,0]';
		
		% List of tracer particles for display
		particles(1).link = 4; % which link?
		particles(1).point = [0.0,0.0]'; % tracer particle point in local coords
		particles(2).link = 4;
		particles(2).point = [10,0]';
	case 4
		% Peaucellier-Lipkin
        
        oscillation = true;
        max_theta = pi/3;
        min_theta = -pi/3;
        
        % Calculate lengths
        a = 2; % side length of the rhombus
        b = 2; % length of driver + stationary link
        c = sqrt((b*(b+(a*sqrt(2)))) + (a^2));
        d = .5*(a*sqrt(2));
        
        % Stationary link. Height: .2, Length: 2.0, Angle: 0�
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-1 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  b/2  b/2  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Driver link. Height: .2, Length: 2.0, Angle: 0�
		links(2).angle = 0;
		links(2).pos = [(b/2 - 1) 0]';
		links(2).verts = [
			 0.0  b/2  b/2  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Rhombus orientation correlates with the driver being at max_theta
        % Rhombus link 1 (left side). Height: .2, Length: a, Angle: 45�
		links(3).angle = pi/4;
		links(3).pos = [b-1 0]';
		links(3).verts = [
			 0.0  a  a  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Rhombus link 2 (bottom). Height: .2, Length: a, Angle: 45�
		links(4).angle = -pi/4;
		links(4).pos = [b-1 0]';
		links(4).verts = [
			 0.0  a  a  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Rhombus link 3 (right side). Height: .2, Length: a, Angle: 45�
		links(5).angle = pi/4;
		links(5).pos = [(b-1+d) -d]';
		links(5).verts = [
			 0.0  a  a  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Rhombus link 4 (top). Height: .2, Length: a, Angle: -45�
		links(6).angle = -pi/4;
		links(6).pos = [(b-1+d) d]';
		links(6).verts = [
			 0.0  a  a  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Long link 1. Height: .2, Length: c, Angle: 30�
		links(7).angle = pi/6;
		links(7).pos = [-1 0]';
		links(7).verts = [
			 0.0  c  c  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Long link 2. Height: .2, Length: c, Angle: -30�
		links(8).angle = -pi/6;
		links(8).pos = [-1 0]';
		links(8).verts = [
			 0.0  c  c  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
        
        % Stationary-Long link 1 
		pins(1).linkA = 1;
		pins(1).linkB = 7;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
        % Stationary-Long link 2 
		pins(2).linkA = 1;
		pins(2).linkB = 8;
		pins(2).pointA = [0,0]';
		pins(2).pointB = [0,0]';
		% Stationary-Driver
		pins(3).linkA = 1;
		pins(3).linkB = 2;
		pins(3).pointA = [b/2,0]';
		pins(3).pointB = [0,0]';
		% Driver-Rhombus link 1 (left)
		pins(4).linkA = 2;
		pins(4).linkB = 3;
		pins(4).pointA = [b/2,0]';
		pins(4).pointB = [0,0]';
		% Driver-Rhombus link 2 (bottom)
		pins(5).linkA = 2;
		pins(5).linkB = 4;
		pins(5).pointA = [b/2,0]';
		pins(5).pointB = [0,0]';
        % Rhombus link 1(left)-Rhombus link 4 (top)
		pins(6).linkA = 3;
		pins(6).linkB = 6;
		pins(6).pointA = [a,0]';
		pins(6).pointB = [0,0]';
        % Rhombus link 2(bottom)-Rhombus link 3 (right)
		pins(7).linkA = 4;
		pins(7).linkB = 5;
		pins(7).pointA = [a,0]';
		pins(7).pointB = [0,0]';
        % Rhombus link 4(top)-Rhombus link 3 (right)
		pins(8).linkA = 6;
		pins(8).linkB = 5;
		pins(8).pointA = [a,0]';
		pins(8).pointB = [a,0]';
        % Long link 1-Rhombus link 1 (left)
		pins(9).linkA = 7;
		pins(9).linkB = 3;
		pins(9).pointA = [c,0]';
		pins(9).pointB = [a,0]';
        % Long link 2-Rhombus link 2 (bottom)
		pins(10).linkA = 8;
		pins(10).linkB = 4;
		pins(10).pointA = [c,0]';
		pins(10).pointB = [a,0]';
		
		% List of tracer particles for display
		particles(1).link = 5; % which link?
		particles(1).point = [a,0.0]'; % tracer particle point in local coords
		particles(2).link = 2;
		particles(2).point = [b/2,0]';
       
	case 5
		% Klann
        
        % Stationary base.
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [0 0]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 -266.16  0.0  -266.16
			-130 0.0  61.45
			];
        
        % Driver. Height: .2, Length: 110 , Angle: -90�
		links(2).angle = -pi/2;
		links(2).pos = [0 0]';
		links(2).verts = [
			 0.0  110  110  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        
        % Brace 1 (top). Height: .2, Length: 182 , Angle: 0�
		links(3).angle = 0;
		links(3).pos = [0 0]';
		links(3).verts = [
			 0.0  182  182  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Brace 2 (bottom). Height: .2, Length: 130 , Angle: 0�
		links(4).angle = 0;
		links(4).pos = [0 0]';
		links(4).verts = [
			 0.0  130  130  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg part 1.
		links(5).angle = 0;
		links(5).pos = [0 0]';
		links(5).verts = [
			 0.0  288  288  0.0  -216.65  -216.65
			-0.1  -0.1  0.1  0.1  48.30  48.10
			];
        
        % Leg part 2.
		links(6).angle = 0;
		links(6).pos = [0 0]';
		links(6).verts = [
			 0.0  265  734.57  734.57  265 0.0
			-0.1 -0.1  139.9  140.1  0.1 0.1
			];
        
        % Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
        
        % Stationary-Driver 
		pins(1).linkA = 1;
		pins(1).linkB = 2;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
        % Stationary-Brace 1 (top) 
		pins(2).linkA = 1;
		pins(2).linkB = 3;
		pins(2).pointA = [-266.16,61.45]';
		pins(2).pointB = [0,0]';
		% Stationary-Brace 2 (bottom)
		pins(3).linkA = 1;
		pins(3).linkB = 4;
		pins(3).pointA = [-266.16,-130]';
		pins(3).pointB = [0,0]';
 		% Driver-Leg part 1
 		pins(4).linkA = 2;
 		pins(4).linkB = 5;
 		pins(4).pointA = [110,0]';
 		pins(4).pointB = [288,0]';
        % Brace 1 (top)- Leg part 2
 		pins(5).linkA = 3;
 		pins(5).linkB = 6;
 		pins(5).pointA = [182,0]';
 		pins(5).pointB = [0,0]';
 		% Brace 2 (bottom)-Leg part 1
 		pins(6).linkA = 4;
 		pins(6).linkB = 5;
 		pins(6).pointA = [130,0]';
 		pins(6).pointB = [0,0]';
        % Leg part 1-Leg part 2
 		pins(7).linkA = 5;
 		pins(7).linkB = 6;
 		pins(7).pointA = [-216.65,38.53]';
 		pins(7).pointB = [265,0]';
        
        % List of tracer particles for display
		particles(1).link = 6; % which link?
		particles(1).point = [734.57,140]'; % tracer particle point in local coords
        
	case 6
		% Jansen's linkage
        
        % Stationary link. Height: .2, Length: 38.79226727, Angle: 0�
		links(1).angle = 0; % rotation from the positive x-axis
		links(1).pos = [-38 -7.8]'; % position of the center of rotation
		links(1).verts = [ % display vertices
			 0.0  38.0  38.0
			 0.0 0.0  7.8
			];
        
        % Driver link. Height: .2, Length: 15.0, Angle: 0�
		links(2).angle = 0;
		links(2).pos = [0 0]';
		links(2).verts = [
			 0.0  15.0  15.0  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 1 green. Height: .2, Length: 50.0, Angle: 0�
		links(3).angle = 0;
		links(3).pos = [0 0]';
		links(3).verts = [
			 0.0  50.0  50.0  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 2 orange. Height: .2, Length: 61.9, Angle: 0�
		links(4).angle = 0;
		links(4).pos = [0 0]';
		links(4).verts = [
			 0.0  61.9  61.9  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 3 red1. Height: .2, Length: 41.5, Angle: 0�
		links(5).angle = 0;
		links(5).pos = [-80 25]';
		links(5).verts = [
			 0.0  41.5  41.5  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 4 red2. Height: .2, Length: 55.8, Angle: 0�
		links(6).angle = 0;
		links(6).pos = [0 0]';
		links(6).verts = [
			 0.0  55.8  55.8  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 5 red3. Height: .2, Length: 40.1, Angle: 0�
		links(7).angle = pi;
		links(7).pos = [0 0]';
		links(7).verts = [
			 0.0  40.1  40.1  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 6 purple. Height: .2, Length: 39.4, Angle: 0�
		links(8).angle = 0;
		links(8).pos = [-76 -20]';
		links(8).verts = [
			 0.0  39.4  39.4  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 7 brown. Height: .2, Length: 39.3, Angle: 0�
		links(9).angle = 0;
		links(9).pos = [0 -7.8]';
		links(9).verts = [
			 0.0  39.3  39.3  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 8 blue1. Height: .2, Length: 36.7, Angle: 0�
		links(10).angle = 0;
		links(10).pos = [0 0]';
		links(10).verts = [
			 0.0  36.7  36.7  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 9 blue2. Height: .2, Length: 65.7, Angle: 0�
		links(11).angle = 0;
		links(11).pos = [-76 -20]';
		links(11).verts = [
			 0.0  65.7  65.7  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Leg link 10 blue3. Height: .2, Length: 49.0, Angle: 0�
		links(12).angle = 0;
		links(12).pos = [0 0]';
		links(12).verts = [
			 0.0  49.0  49.0  0.0
			-0.1 -0.1  0.1  0.1
			];
        
        % Which link is grounded?
		grounded = 1;
		% Which link is the driver?
		% Note: the driver must be attached (with a pin) to the ground.
		driver = 2;
        
        % Stationary-Leg link 3
		pins(1).linkA = 1;
		pins(1).linkB = 5;
		pins(1).pointA = [0,0]';
		pins(1).pointB = [0,0]';
        % Stationary-Leg link 5 
		pins(2).linkA = 1;
		pins(2).linkB = 7;
		pins(2).pointA = [0,0]';
		pins(2).pointB = [0,0]';
		% Stationary-Leg link 7
		pins(3).linkA = 1;
		pins(3).linkB = 9;
		pins(3).pointA = [0,0]';
		pins(3).pointB = [0,0]';
        
		% Stationary-Driver
		pins(4).linkA = 1;
		pins(4).linkB = 2;
		pins(4).pointA = [38.0,7.8]';
		pins(4).pointB = [0,0]';
        
		% Driver-Leg link 1
		pins(5).linkA = 2;
		pins(5).linkB = 3;
		pins(5).pointA = [15.0,0]';
		pins(5).pointB = [0,0]';
        % Driver-Leg link 2
		pins(6).linkA = 2;
		pins(6).linkB = 4;
		pins(6).pointA = [15.0,0]';
		pins(6).pointB = [0,0]';
        
        % Leg link 1-Leg link 3
		pins(7).linkA = 3;
		pins(7).linkB = 5;
		pins(7).pointA = [50.0,0]';
		pins(7).pointB = [41.5,0]';
        % Leg link 1-Leg link 4
		pins(8).linkA = 3;
		pins(8).linkB = 6;
		pins(8).pointA = [50.0,0]';
		pins(8).pointB = [0,0]';
        % Leg link 3-Leg link 4
		pins(9).linkA = 5;
		pins(9).linkB = 6;
		pins(9).pointA = [41.5,0]';
		pins(9).pointB = [0,0]';
        
        
        % Leg link 4-Leg link 5
		pins(10).linkA = 6;
		pins(10).linkB = 7;
		pins(10).pointA = [55.8,0]';
		pins(10).pointB = [40.1,0]';
        % Leg link 4-Leg link 6
		pins(11).linkA = 6;
		pins(11).linkB = 8;
		pins(11).pointA = [55.8,0]';
		pins(11).pointB = [0,0]';
        % Leg link 5-Leg link 6
		pins(12).linkA = 7;
		pins(12).linkB = 8;
		pins(12).pointA = [40.1,0]';
		pins(12).pointB = [0,0]';
        
        
        % Leg link 6-Leg link 8
		pins(13).linkA = 8;
		pins(13).linkB = 10;
		pins(13).pointA = [39.4,0]';
		pins(13).pointB = [0,0]';
        % Leg link 6-Leg link 9
		pins(14).linkA = 8;
		pins(14).linkB = 11;
		pins(14).pointA = [39.4,0]';
		pins(14).pointB = [0,0]';
        
        % Leg link 2-Leg link 7
		pins(15).linkA = 4;
		pins(15).linkB = 9;
		pins(15).pointA = [61.9,0]';
		pins(15).pointB = [39.3,0]';
        % Leg link 2-Leg link 8
		pins(16).linkA = 4;
		pins(16).linkB = 10;
		pins(16).pointA = [61.9,0]';
		pins(16).pointB = [36.7,0]';
        % Leg link 2-Leg link 10
		pins(17).linkA = 4;
		pins(17).linkB = 12;
		pins(17).pointA = [61.9,0]';
		pins(17).pointB = [0,0]';
        % Leg link 8-Leg link 10
		pins(18).linkA = 10;
		pins(18).linkB = 12;
		pins(18).pointA = [36.7,0]';
		pins(18).pointB = [0,0]';
        % Leg link 7-Leg link 8
        pins(19).linkA = 9;
		pins(19).linkB = 10;
		pins(19).pointA = [39.3,0]';
		pins(19).pointB = [36.7,0]';
        % Leg link 7-Leg link 10
        pins(20).linkA = 9;
		pins(20).linkB = 12;
		pins(20).pointA = [39.3,0]';
		pins(20).pointB = [0,0]';
        
        % Leg link 9-Leg link 10
		pins(21).linkA = 11;
		pins(21).linkB = 12;
		pins(21).pointA = [65.7,0]';
		pins(21).pointB = [49.0,0]';
		
		% List of tracer particles for display
		particles(1).link = 12; % which link?
		particles(1).point = [49.0,0.0]'; % tracer particle point in local coords
		particles(2).link = 2;
		particles(2).point = [15,0]';
        
	case 10
		% Extra credit!
end

% Initialize
for i = 1 : length(links)
	links(i).grounded = (i == grounded); %#ok<*AGROW>
	links(i).driver = (i == driver);
	% These target quantities are only used for grounded and driver links
	links(i).angleTarget = links(i).angle;
	links(i).posTarget = links(i).pos;
end
for i = 1 : length(particles)
	particles(i).pointsWorld = zeros(2,0); % transformed points, initially empty
end

% Debug: drawing here to debug scene setup
%drawScene(0,links,pins,sliders,particles);

% lsqnonlin options
if verLessThan('matlab','8.1')
	opt = optimset(...
		'Jacobian','on',...
		'DerivativeCheck','off',...
		'Display','off'); % final-detailed iter-detailed off
else
	opt = optimoptions('lsqnonlin',...
		'Jacobian','on',...
		'DerivativeCheck','off',...
		'Display','off'); % final-detailed iter-detailed off
end

% Simulation loop
t = 0; % current time
T = 1; % final time
dt = 0.01; % time step
angVel = 2*pi; % driver angular velocity
w = 20; % Angular frequency

while t < T
	% Procedurally set the driver angle.
	% Right now, the target angle is being linearly increased, but you may
	% want to do something else.
    
    if oscillation
        target =(max_theta-min_theta)*-cos(w*t)/2 +(max_theta+min_theta)/2;
    else
        target = links(driver).angleTarget + dt*angVel;
    end
    
    links(driver).angleTarget = target;
    
	% Solve for linkage orientations and positions
	[links,feasible] = solveLinkage(links,pins,sliders,opt);
	% Update particle positions
	particles = updateParticles(links,particles);
	% Draw scene
	drawScene(t,links,pins,sliders,particles);
	% Quit if over-constrained
	if ~feasible
		break;
	end
	t = t + dt;
end

end

%%
function [R,dR] = rotationMatrix(angle)
c = cos(angle);
s = sin(angle);
% Rotation matrix
R = zeros(2);
R(1,1) = c;
R(1,2) = -s;
R(2,1) = s;
R(2,2) = c;
if nargout >= 2
	% Rotation matrix derivative
	dR = zeros(2);
	dR(1,1) = -s;
	dR(1,2) = -c;
	dR(2,1) = c;
	dR(2,2) = -s;
end
end

%%
function [links,feasible] = solveLinkage(links,pins,sliders,opt)
nlinks = length(links);
% Extract the current angles and positions into a vector
angPos0 = zeros(3*nlinks,1);
for i = 1 : nlinks
	link = links(i);
	ii = (i-1)*3+(1:3);
	angPos0(ii(1)) = link.angle;
	angPos0(ii(2:3)) = link.pos;
end
% Limits
lb = -inf(size(angPos0));
ub =  inf(size(angPos0));
% Solve for angles and positions
[angPos,r2] = lsqnonlin(@(angPos)objFun(angPos,links,sliders,pins),angPos0,lb,ub,opt);
% If the mechanism is feasible, then the residual should be zero
feasible = true;
if r2 > 1e-6
	fprintf('Mechanism is over constrained!\n');
	feasible = false;
end
% Extract the angles and positions from the values in the vector
for i = 1 : length(links)
	ii = (i-1)*3+(1:3);
	links(i).angle = angPos(ii(1));
	links(i).pos = angPos(ii(2:3));
end
end

%%
function [c,J] = objFun(angPos,links,sliders,pins)
nlinks = length(links);
npins = length(pins);
nsliders = length(sliders);
% Temporarily change angles and positions of the links. These changes will
% be undone when exiting this function.
for i = 1 : nlinks
	ii = (i-1)*3+(1:3);
	links(i).angle = angPos(ii(1));
	links(i).pos = angPos(ii(2:3));
end

% Evaluate constraints
ndof = 3*nlinks;
ncon = 3 + 3 + 2*npins; % 3 for ground, 3 for driver, 2*npins for pins
c = zeros(ncon,1);
J = zeros(ncon,ndof);
k = 0;
% Some angles and positions are fixed
for i = 1 : nlinks
	link = links(i);
	if link.grounded || link.driver
		% Grounded and driver links have their angles and positions
		% prescribed.
		c(k+1,    1) = link.angle - link.angleTarget;
		c(k+(2:3),1) = link.pos - link.posTarget;
		% The Jacobian of this constraint is the identity matrix
		colAng = (i-1)*3 + 1;
		colPos = (i-1)*3 + (2:3);
		J(k+1,    colAng) = 1;
		J(k+(2:3),colPos) = eye(2);
		k = k + 3;
	end
end
% Pin constraints
for i = 1 : npins
	pin = pins(i);
	rows = k+(1:2); % row index of this pin constraint
	k = k + 2;
	indLinkA = pin.linkA; % array index of link A
	indLinkB = pin.linkB; % array index of link B
	linkA = links(indLinkA);
	linkB = links(indLinkB);
	[Ra,dRa] = rotationMatrix(linkA.angle);
	[Rb,dRb] = rotationMatrix(linkB.angle);
	% Local positions
	ra = pin.pointA;
	rb = pin.pointB;
	% World positions
	xa = Ra * ra + linkA.pos;
	xb = Rb * rb + linkB.pos;
	p = xa(1:2) - xb(1:2);
	c(rows,1) = p;
	%
	% Optional Jacobian computation
	%
	% Column indices for the angles and positions of links A and B
	colAngA = (indLinkA-1)*3 + 1;
	colPosA = (indLinkA-1)*3 + (2:3);
	colAngB = (indLinkB-1)*3 + 1;
	colPosB = (indLinkB-1)*3 + (2:3);
	% The Jacobian of this constraint is the partial derivative of f wrt
	% the angles and positions of the two links.
	J(rows,colAngA) = dRa * ra;
	J(rows,colPosA) = eye(2);
	J(rows,colAngB) = -dRb * rb;
	J(rows,colPosB) = -eye(2);
end
end

%%
function particles = updateParticles(links,particles)
% Transform particle position from local to world
for i = 1 : length(particles)
	particle = particles(i);
	link = links(particle.link);
    R = rotationMatrix(link.angle);
	x = R * particle.point + link.pos;
	% Append world position to the array (grows indefinitely)
	particles(i).pointsWorld(:,end+1) = x;
end
end

%%
function drawScene(t,links,pins,sliders,particles)
if t == 0
	clf;
	axis equal;
	hold on;
	grid on;
	xlabel('X');
	ylabel('Y');
end
cla;
% Draw links
for i = 1 : length(links)
	link = links(i);
	R = rotationMatrix(link.angle);
	% Draw frame
	p = link.pos; % frame origin
	s = 0.2; % frame display size
	px = p + s*R(:,1); % frame x-axis
	py = p + s*R(:,2); % frame y-axis
	plot([p(1),px(1)],[p(2),px(2)],'r','LineWidth',3);
	plot([p(1),py(1)],[p(2),py(2)],'g','LineWidth',3);
	% Draw link geometry
	if link.grounded
		color = [1 0 0];
	elseif link.driver
		color = [0 1 0];
	else
		color = [0 0 1];
	end
	E = [R,link.pos;0,0,1]; % transformation matrix
	vertsLocal = [link.verts;ones(1,size(link.verts,2))];
	vertsWorld = E * vertsLocal;
	plot(vertsWorld(1,[1:end,1]),vertsWorld(2,[1:end,1]),'Color',color);
end
% Draw pins
for i = 1 : length(pins)
	pin = pins(i);
	linkA = links(pin.linkA);
	linkB = links(pin.linkB);
	Ra = rotationMatrix(linkA.angle);
	Rb = rotationMatrix(linkB.angle);
	xa = Ra * pin.pointA + linkA.pos;
	xb = Rb * pin.pointB + linkB.pos;
	plot(xa(1),xa(2),'co','MarkerSize',10,'MarkerFaceColor','c');
	plot(xb(1),xb(2),'mx','MarkerSize',10,'LineWidth',2);
end
% Draw particles
for i = 1 : length(particles)
	particle = particles(i);
	if ~isempty(particle.pointsWorld)
		plot(particle.pointsWorld(1,:),particle.pointsWorld(2,:),'k');
		plot(particle.pointsWorld(1,end),particle.pointsWorld(2,end),'ko');
	end
end
%axis equal;
title(sprintf('t=%.3f',t));
drawnow;
end
