function mutual_info_matrix = get_mutual_info_matrix(train_data, metadata)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
n_attributes = size(train_data, 2) - 1;
y_vector = train_data(:, end);
unique_y = metadata.attribute_values{end};
mutual_info_matrix = -1*ones(n_attributes, n_attributes);
for i = 1:n_attributes
    for j = i+1:n_attributes
        x1_vector = train_data(:, i);
        x2_vector = train_data(:, j);
        unique_x1 = metadata.attribute_values{i};
        unique_x2 = metadata.attribute_values{j};
        mutual_info_matrix(i, j) = get_conditional_mutual_information(unique_x1, unique_x2, unique_y, x1_vector, x2_vector, y_vector);
        %mutual_info_matrix(i, j) = get_mutual_information(unique_x1, unique_x2, x1_vector, x2_vector);
        mutual_info_matrix(j, i) = mutual_info_matrix(i, j);
    end
end
end