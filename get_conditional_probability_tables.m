function cpt = get_conditional_probability_tables(train_data, meta, edges)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n_attributes = size(train_data, 2) - 1;
n_instances  = size(train_data, 1);
pseudocount = 1;

% generate tables for each of the variables
% index 1 is the root
x1_vector = train_data(:, 1);
unique_x1 = meta.attribute_values{1};
y_vector  = train_data(:, end);
unique_y  = meta.attribute_values{end};
p_x1_y = pseudocount * ones(length(unique_x1), length(unique_y));

for k = 1:n_instances
    for i = 1:length(unique_x1)
        for l = 1:length(unique_y)
            if (strcmp(x1_vector(k), unique_x1(i)) ...
                    && strcmp(y_vector(k), unique_y(l)))
                p_x1_y(i, l) = p_x1_y(i, l) + 1;
            end
        end
    end
end
count_y = zeros(1, length(unique_y));
for k = 1:n_instances
    for l = 1:length(unique_y)
        if strcmp(y_vector(k), unique_y(l))
            count_y(l) = count_y(l) + 1;
        end
    end
end
for l = 1:length(unique_y)
    p_x1_y(:, l) = p_x1_y(:, l)/(count_y(l) + length(unique_x1) * pseudocount);
end
cpt{1} = p_x1_y;


for curr_vertex_idx = 2:n_attributes
    idx = find(edges(:, 2)==curr_vertex_idx);
    parent_idx = edges(idx, 1);
    x1_vector = train_data(:, curr_vertex_idx);
    x2_vector = train_data(:, parent_idx);
    unique_x1 = meta.attribute_values{curr_vertex_idx};
    unique_x2 = meta.attribute_values{parent_idx};
    
    p_x1_x2y = pseudocount * ones(length(unique_x1), length(unique_x2), length(unique_y));
    count_x2y = zeros(length(unique_x2), length(unique_y));
    for k = 1:n_instances
        for i = 1:length(unique_x1)
            for j = 1:length(unique_x2)
                for l = 1:length(unique_y)
                    if (strcmp(x1_vector(k), unique_x1(i)) ...
                            && strcmp(x2_vector(k), unique_x2(j)) ...
                            && strcmp(y_vector(k), unique_y(l)))
                        p_x1_x2y(i, j, l) = p_x1_x2y(i, j, l) + 1;
                    end
                end
            end
        end
        
        for j = 1:length(unique_x2)
            for l = 1:length(unique_y)
                if (strcmp(x2_vector(k), unique_x2(j)) ...
                 && strcmp(y_vector(k), unique_y(l)))
                    count_x2y(j, l) = count_x2y(j, l) + 1;
                end
            end
        end
    end
    for j = 1:length(unique_x2)
        for l = 1:length(unique_y)
            p_x1_x2y(:, j, l) = p_x1_x2y(:, j, l)/(count_x2y(j, l) + length(unique_x1) * pseudocount);
        end
    end
    cpt{curr_vertex_idx} = p_x1_x2y;
end
cpt{n_attributes + 1} = (count_y + pseudocount * ones(1, length(unique_y)))/(n_instances + pseudocount * length(unique_y));
end