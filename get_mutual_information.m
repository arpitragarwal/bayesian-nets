function mutual_info = get_mutual_information(unique_x, unique_y, x_vector, y_vector)
%UNTITLED5 Summary of this function goes here
%   I(x, y) = \sum_x \sum_y p(x, y) log_2 (p(x, y)/p(x)p(y))
n_instances = length(x_vector);
pseudocount = 1;
p_x  = pseudocount * ones(length(unique_x), 1);
p_y  = pseudocount * ones(length(unique_y), 1);
p_xy = pseudocount * ones(length(unique_x), length(unique_y));
for k = 1:n_instances
    for i = 1:length(unique_x)
        if strcmp(x_vector(k), unique_x(i))
            p_x(i) = p_x(i) + 1;
        end
    end
    for j = 1:length(unique_y)
        if strcmp(y_vector(k), unique_y(j))
            p_y(j) = p_y(j) + 1;
        end
    end
    for i = 1:length(unique_x)
        for j = 1:length(unique_y)
            if (strcmp(x_vector(k), unique_x(i)) && strcmp(y_vector(k), unique_y(j)))
                p_xy(i, j) = p_xy(i, j) + 1;
            end
        end
    end
end
p_x  = p_x /(n_instances + length(unique_x) * pseudocount);
p_y  = p_y /(n_instances + length(unique_y) * pseudocount);
p_xy = p_xy/(n_instances + length(unique_x) * length(unique_y) * pseudocount);

mutual_info = 0;
for i = 1:length(unique_x)
    for j = 1:length(unique_y)
        if p_xy(i, j) ~= 0
            tmp = log(p_xy(i, j)) - (log(p_x(i)) + log(p_y(j)));
            tmp = tmp/log(2);
            mutual_info = mutual_info + p_xy(i, j) * tmp;
        else
            disp("WARNING: Something is wrong.")
        end
    end
end

end