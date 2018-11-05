function mutual_info = get_conditional_mutual_information(unique_x1, unique_x2, unique_y, x1_vector, x2_vector, y_vector)
%UNTITLED5 Summary of this function goes here
%   I(x, y) = \sum_x \sum_y p(x, y) log_2 (p(x, y)/p(x)p(y))

n_instances = length(x1_vector);
pseudocount = 1;
p_x1_y   = pseudocount * ones(length(unique_x1), length(unique_y));
p_x2_y   = pseudocount * ones(length(unique_x2), length(unique_y));
p_x1x2_y = pseudocount * ones(length(unique_x1), length(unique_x2), length(unique_y));
p_x1x2y  = pseudocount * ones(length(unique_x1), length(unique_x2), length(unique_y));
count_y  = zeros(length(unique_y), 1);
for k = 1:n_instances
    for i = 1:length(unique_x1)
        for l = 1:length(unique_y)
            if strcmp(x1_vector(k), unique_x1(i)) && strcmp(y_vector(k), unique_y(l))
                p_x1_y(i, l) = p_x1_y(i, l) + 1;
            end
        end
    end
    for j = 1:length(unique_x2)
        for l = 1:length(unique_y)
            if strcmp(x2_vector(k), unique_x2(j)) && strcmp(y_vector(k), unique_y(l))
                p_x2_y(j, l) = p_x2_y(j, l) + 1;
            end
        end
    end
    for i = 1:length(unique_x1)
        for j = 1:length(unique_x2)
            for l = 1:length(unique_y)
                if        (strcmp(x1_vector(k), unique_x1(i)) ...
                        && strcmp(x2_vector(k), unique_x2(j)) ...
                        && strcmp( y_vector(k), unique_y (l)))
                    p_x1x2_y(i, j, l) = p_x1x2_y(i, j, l) + 1;
                    p_x1x2y(i, j, l) = p_x1x2y(i, j, l) + 1;
                end
            end
        end
    end
    for l = 1:length(unique_y)
        if (strcmp(y_vector(k), unique_y(l)))
            count_y(l) = count_y(l) + 1;
        end
    end
end

for l = 1:length(unique_y)
    p_x1_y(:, l)      = p_x1_y(:, l)      / (count_y(l) + length(unique_x1) * pseudocount);
    p_x2_y(:, l)      = p_x2_y(:, l)      / (count_y(l) + length(unique_x2) * pseudocount);
    p_x1x2_y(:, :, l) = p_x1x2_y(:, :, l) / (count_y(l) + length(unique_x1) * length(unique_x2) * pseudocount);
end
p_x1x2y  = p_x1x2y/(n_instances + length(unique_x1) * length(unique_x2) * length(unique_y) * pseudocount);

mutual_info = 0;
for i = 1:length(unique_x1)
    for j = 1:length(unique_x2)
        for l = 1:length(unique_y)
            if p_x1x2_y(i, j, l) ~= 0
                tmp = log(p_x1x2_y(i, j, l)) - (log(p_x1_y(i, l)) + log(p_x2_y(j, l)));
                tmp = tmp/log(2);
                mutual_info = mutual_info + (p_x1x2y(i, j, l) * tmp);
            end
        end
    end
end

end