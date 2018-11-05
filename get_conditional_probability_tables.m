function cpt = get_conditional_probability_tables(train_data, meta, edges)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n_attributes = size(train_data, 2) - 1;
n_instances  = size(train_data, 1);
pseudocount = 1;

for curr_vertex_idx = 2:n_attributes
    % generate tables for each of the variables
    % i = 1 is the root
    idx = find(edges(:, 2)==curr_vertex_idx);
    parent_idx = edges(idx, 1);
    x1_vector = train_data(:, curr_vertex_idx);
    x2_vector = train_data(:, parent_idx);
    y_vector  = train_data(:, end);
    
    unique_x1 = meta.attribute_values{curr_vertex_idx};
    unique_x2 = meta.attribute_values{parent_idx};
    unique_y  = meta.attribute_values{end};
    
    p_x1x2_y = pseudocount * ones(length(unique_x1), length(unique_x2), length(unique_y));
    for k = 1:n_instances
        for i = 1:length(unique_x1)
            for j = 1:length(unique_x2)
                for l = 1:length(unique_y)
                    if (strcmp(x1_vector(k), unique_x1(i)) ...
                            && strcmp(x2_vector(k), unique_x2(j)) ...
                            && strcmp(y_vector(k), unique_y(l)))
                        p_x1x2_y(i, j, l) = p_x1x2_y(i, j, l) + 1;
                    end
                end
            end
        end
    end
    cpt{curr_vertex_idx} = p_x1x2_y/(n_instances + length(unique_x1) * length(unique_x2)* length(unique_y) * pseudocount);
end
end