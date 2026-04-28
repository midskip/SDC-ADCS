%% For if we are facing earth subject to some confidence level
% Returns some boolean (yes or no)

sigma = 1.0; % Confidence level. 1.0->66%, 2.0->95%, 3.0->99.7%

orientation_IB = [1, 0, 0, 0];

% TODO define some body axes at some point
camera_vec_body = [1, 0, 0]'; % Define camera direction in body frame (unit)

camera_vec_inertial = quat2rotm(orientation_IB) * camera_vec_body;

pos = [123131, 223912, 943299]'; % TODO replace in sim. Random for now
pos_normed = -1.0 * pos / norm(pos); % Multiply by -1 to flip vec direction

theta = acos(dot(camera_vec_inertial, pos_normed));

% Axis not really important, but good to have
axis = cross(camera_vec_inertial, pos_normed);
axis = norm(axis);

P = [1, 2, 3]'; % TODO replace in sim. P defined in inertial frame, so need to rot
P_body = quat2rotm(orientation_IB)' * P;
P_added_theta = hypot(abs(P_body(2, 1)), abs(P_body(3, 1))); % Euclid dist. Small angle approx

rad_earth = 6378100; % radius of earth (m) according to Chat
fov_earth = deg2rad(atan(rad_earth / pos));
fov_camera = deg2rad(60); % TODO: Ask what is the fov of the camera, validate correct ideas

% I think this math works out. Angles are weird tho so idk
if (abs(theta) + (deg2rad(fov_earth) / 2.0) + (sigma * P_added_theta) < (fov_earth / 2.0))
    disp("Open camera");
else
    disp("Keep camera closed");
end

%{
% Old logic, probably wrong
if (theta < deg2rad(fov_earth / 2.0) - deg2rad(fov_camera / 2.0) - (sigma * P_added_theta))
    disp("Open camera");
else
    disp("Keep camera closed");
end
%}





