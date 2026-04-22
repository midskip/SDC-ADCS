%% For earth

orientation_IB = [1, 0, 0, 0];

% TODO define some body axes at some point
camera_vec_body = [1, 0, 0]'; % Define camera direction in body frame (unit)

camera_vec_inertial = quat2rotm(orientation_IB) * camera_vec_body;

pos = [123131, 223912, 943299]'; % TODO replace. Random for now
pos_normed = pos / norm(pos);

theta = acos(dot(camera_vec_inertial, pos_normed));

axis = cross(camera_vec_inertial, pos_normed);
axis = norm(axis);

P = [1, 2, 3]'; % TODO replace
P_body = quat2rotm(orientation_IB)' * P;
P_added_theta = hypot(P_body(2, 1), P_body(3, 1));
sigma = 1.0;

fov_earth = 150; % TODO find real number
fov_camera = 60;

if (theta < deg2rad(fov_earth / 2.0) - deg2rad(fov_camera / 2.0) - (sigma * P_added_theta))
    disp("Open camera");
else
    disp("Keep camera closed");
end

% TODO: Ask what is the fov of the camera, validate correct ideas



