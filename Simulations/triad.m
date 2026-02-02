function R_IB = triad(v_1b, v_2b, v_1i, v_2i)
% Returns a DCM Body -> Inertial
    % Normalize the input vectors
    v_1b = v_1b / norm(v_1b);
    v_2b = v_2b / norm(v_2b);
    v_1i = v_1i / norm(v_1i);
    v_2i = v_2i / norm(v_2i);

    % Calculate the reference vectors in inertial frame
    q_i = v_1i;
    r_i = cross(v_1i, v_2i) / norm(cross(v_1i, v_2i));
    s_i = cross(q_i, r_i);

    M_i = [q_i, r_i, s_i];

    % Calculate the reference vectors in body frame
    q_b = v_1b;
    r_b = cross(v_1b, v_2b) / norm(cross(v_1b, v_2b)); % Corrected to use m_b for body frame
    s_b = cross(q_b, r_b);

    M_b = [q_b, r_b, s_b];

    % Calculate dcm body -> inertial
    R_IB = M_i * M_b';
end
